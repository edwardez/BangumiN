import {Component, OnInit, ViewEncapsulation} from '@angular/core';
import {FormBuilder, FormGroup} from '@angular/forms';
import {BanguminUserService} from '../../shared/services/bangumin/bangumin-user.service';
import {BangumiStatsService} from '../../shared/services/bangumi/bangumi-stats.service';
import {ActivatedRoute} from '@angular/router';
import * as _ from 'lodash';
import {SubjectType} from '../../shared/enums/subject-type.enum';
import {CollectionStatusId} from '../../shared/enums/collection-status-id';
import * as day from 'dayjs';
import {filter} from 'rxjs/operators';

@Component({
  selector: 'app-subject-statistics',
  templateUrl: './subject-statistics.component.html',
  styleUrls: ['./subject-statistics.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class SubjectStatisticsComponent implements OnInit {
  // todo: options for each chart
  view;
  showXAxis;
  showYAxis;
  gradient;
  showLegend;
  showGridLines;
  showXAxisLabel;
  xAxisLabel;
  showYAxisLabel;
  yAxisLabel;
  colorScheme;
  scoreVsCountData;
  theme;

  subjectTypeList;
  collectionStatusList;
  selectedTypeListForscoreVsCount;

  rangeFillOpacity = 0.15;
  schemeType = 'ordinal';
  yearVsMeanData = [];
  // triggerValue;

  countByTypeData;

  targetSubject;
  // raw data - CONST!
  targetSubjectStatsArr;

  yearVsMeanFilterFormGroup: FormGroup;
  scoreVsCountFilterFormGroup: FormGroup;
  yearCount = {};

  constructor(
    private banguminUserService: BanguminUserService,
    private bangumiStatsService: BangumiStatsService,
    private activatedRoute: ActivatedRoute,
    private formBuilder: FormBuilder
  ) {
    this.view = [800, 500];
    // options
    this.gradient = false;
    this.showLegend = true;
    this.showGridLines = true;
    // todo: translate legend and label
    this.xAxisLabel = 'Score';
    this.showXAxisLabel = true;
    this.showXAxis = true;

    this.yAxisLabel = 'Count';
    this.showYAxisLabel = true;
    this.showYAxis = true;

    this.colorScheme = {
      domain: ['#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00']
    };

    this.selectedTypeListForscoreVsCount = this.subjectTypeList;

    this.initStatsFormGroup();
  }

  ngOnInit() {
    this.activatedRoute.params
      .pipe(
        filter(params => {
          this.targetSubject = params['subjectId'];
          return this.targetSubject;
        })
      )
      .subscribe(params => {
        this.bangumiStatsService.getSubjectStats(this.targetSubject)
          .subscribe(res => {
            if (res) {
              const defaultArr = res.stats;
              // cache stats array
              this.targetSubjectStatsArr = res.stats;
              this.countByTypeData = _.map(_.countBy(defaultArr, 'subjectType'), (val, key) => ({name: SubjectType[key], value: val}));
              // initialize filter list value
              this.subjectTypeList = _.map(this.countByTypeData, 'name');
              this.collectionStatusList = _.map(
                _.uniqBy(defaultArr, 'collectionStatus'), row => CollectionStatusId[row['collectionStatus']]
              );
              // initialize filter form groups
              this.yearVsMeanFilterFormGroup.get('subjectTypeSelect').setValue(this.subjectTypeList);
              this.yearVsMeanFilterFormGroup.get('stateSelect').setValue(this.collectionStatusList);
              this.scoreVsCountFilterFormGroup.get('subjectTypeSelect').setValue(this.subjectTypeList);
              this.scoreVsCountFilterFormGroup.get('stateSelect').setValue(this.collectionStatusList);

              this.initScoreVsCount();
              this.initYearVsMean();
            }
          });
      });
  }

  getYearCount(year) {
    return this.yearCount[year];
  }

  calendarAxisTickFormatting(year) {
    if (Math.floor(year) !== year) {
      return '';
    }
    return day().set('year', year).year();
  }

  pieTooltipText({data}) {
    const label = data.name;
    const val = data.value;

    return `
      <span class="tooltip-label">${label}</span>
      <span class="tooltip-val">${val}</span>
    `;
  }

  getYearScoreMinMax(subjectType, year, minMax) {
    const typeArr = _.filter(this.yearVsMeanData, row => row.name === subjectType);
    const yearArr = _.filter(typeArr[0].series, row => row.name === year);
    return yearArr[0][minMax];
  }

  private initYearVsMean() {
    // initialize the chart with all types
    const selectedTypeListForyearVsMean = this.yearVsMeanFilterFormGroup.value.subjectTypeSelect;
    this.refreshYearVsMean(this.targetSubjectStatsArr, selectedTypeListForyearVsMean);

    // edit the chart on change of subjectType selection
    // use formControl.valueChanges instead of selectionChange since we want to modify the chart minimally,
    // i.e. instead of re-filtering the whole array with selectedList, only add/remove target subjectType from the chart.
    this.yearVsMeanFilterFormGroup.controls['subjectTypeSelect'].valueChanges
      .subscribe(newVal => {
        const oldVal = this.yearVsMeanFilterFormGroup.value.subjectTypeSelect;
        const triggerValue = (newVal.length < oldVal.length) ?
          _.difference(oldVal, newVal)[0] as string : _.difference(newVal, oldVal)[0] as string;
        const action = (newVal.length < oldVal.length) ? 'deSelect' : 'select';
        // selected a value
        if (action === 'select') {
          const thisTypeArr = this.targetSubjectStatsArr
            .filter((stat) => (SubjectType[stat.subjectType] === triggerValue));
          this.groupAndCountByYearOfType(thisTypeArr, triggerValue);
        } else {
          // deselected a value
          const newArr = _.filter(this.yearVsMeanData, (row) => {
            return row.name !== triggerValue;
          });
          this.yearVsMeanData = [...newArr];
        }
      });

    // edit the chart on change of collection status selection
    this.yearVsMeanFilterFormGroup.controls['stateSelect'].valueChanges
      .subscribe(newStateList => {
        const newArr = this.targetSubjectStatsArr
          .filter(stat => newStateList.includes(CollectionStatusId[stat.collectionStatus]));
        this.refreshYearVsMean(newArr, this.yearVsMeanFilterFormGroup.value.subjectTypeSelect);
      });
  }

  private refreshYearVsMean(newYearVsMeanData, selectedTypeList) {
    this.yearVsMeanData = [];
    const arr = newYearVsMeanData
      .filter(stat => selectedTypeList.includes(SubjectType[stat.subjectType]));
    const arrByType = _.groupBy(arr, (row) => {
      return SubjectType[row.subjectType];
    });
    Object.keys(arrByType).forEach((type) => {
      this.groupAndCountByYearOfType(arrByType[type], type);
    });
  }

  private initScoreVsCount() {
    const arr = this.filterBySubjectTypeAndState(
      this.scoreVsCountFilterFormGroup.value.subjectTypeSelect,
      this.scoreVsCountFilterFormGroup.value.stateSelect
    );
    this.groupAndCountByRate(arr);

    // edit the chart on change of subjectType selection
    this.scoreVsCountFilterFormGroup.controls['subjectTypeSelect'].valueChanges
      .subscribe(newTypeList => {
        const newArr = this.filterBySubjectTypeAndState(
          newTypeList,
          this.scoreVsCountFilterFormGroup.value.stateSelect
        );
        this.groupAndCountByRate(newArr);
      });

    // edit the chart on change of collection status selection
    this.scoreVsCountFilterFormGroup.controls['stateSelect'].valueChanges
      .subscribe(newStateList => {
        const newArr = this.filterBySubjectTypeAndState(
          this.scoreVsCountFilterFormGroup.value.subjectTypeSelect,
          newStateList
        );
        this.groupAndCountByRate(newArr);
      });
  }

  private filterBySubjectTypeAndState(subjectTypeList, stateList) {
    return this.targetSubjectStatsArr.filter(stat => {
      return subjectTypeList.includes(SubjectType[stat.subjectType])
        && stateList.includes(CollectionStatusId[stat.collectionStatus]);
    });
  }

  private groupAndCountByRate(newScoreVsCountData) {
    // reject record with null rate
    const arr = newScoreVsCountData.filter(stat => stat.rate);
    // TODO: fixed xAxis ticks
    const xAxisTicks = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
    let countedArr = _.map(_.countBy(arr, 'rate'), (val, key) => ({name: key, value: val}));
    const diff = _.difference(xAxisTicks, countedArr.map(t => t.name));
    // hack fix when no data is available, show empty chart instead of all "0.00000001"
    if (diff.length === 10) {
      countedArr = [];
    } else if (diff.length !== 0) {
      diff.forEach((axis) => {
        countedArr.push({name: axis, value: 0.000001});
      });
    }

    this.scoreVsCountData = countedArr.sort(function (a: any, b: any) {
      return a.name - b.name;
    });
  }

  private initStatsFormGroup() {
    this.yearVsMeanFilterFormGroup = this.formBuilder.group(
      {
        subjectTypeSelect: [[]],
        stateSelect: [[]]
      }
    );

    this.scoreVsCountFilterFormGroup = this.formBuilder.group(
      {
        subjectTypeSelect: [[]],
        stateSelect: [[]]
      }
    );
  }

  private groupAndCountByYearOfType(arr, type: string) {
    const arrByYear = _.groupBy(arr, (row) => {
      return day(row.addDate).year();
    });
    const yearArr = this.getYearArr(_.min(Object.keys(arrByYear)), _.max(Object.keys(arrByYear)));
    yearArr.forEach(row => {
      let tmpArr = arrByYear[row.name];
      if (tmpArr) {
        row.min = (_.minBy(tmpArr, 'rate')) ? +_.minBy(tmpArr, 'rate').rate : 0;
        row.max = (_.maxBy(tmpArr, 'rate')) ? +_.maxBy(tmpArr, 'rate').rate : 0;
        tmpArr = _.reject(tmpArr, (thisRow) => !thisRow.rate);
        // note down the yearCount
        this.yearCount[row.name] = tmpArr.length;
        row.value = (tmpArr.length === 0) ? 0 : _.meanBy(tmpArr, 'rate');
      }
    });
    this.yearVsMeanData = [...this.yearVsMeanData, {name: type, series: yearArr}];
  }

  private getYearArr(minYear, maxYear) {
    return _.range(+minYear, (+maxYear + 1)).map((year) => ({name: year, value: 0, min: 0, max: 0}));
  }

}
