import {Component, OnInit, ViewEncapsulation} from '@angular/core';
import {FormBuilder, FormGroup} from '@angular/forms';
import {BanguminUserService} from '../../shared/services/bangumin/bangumin-user.service';
import {BangumiStatsService} from '../../shared/services/bangumi/bangumi-stats.service';
import {ActivatedRoute} from '@angular/router';
import * as _ from 'lodash';
import {SubjectType} from '../../shared/enums/subject-type.enum';
import {CollectionStatusId} from '../../shared/enums/collection-status-id';
import * as day from 'dayjs';
import {filter, switchMap} from 'rxjs/operators';
import {BangumiSubjectService} from '../../shared/services/bangumi/bangumi-subject.service';

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
  yearVsAccumulatedMeanData = [];
  // triggerValue;

  targetSubject;
  // raw data - CONST!
  targetSubjectStatsArr;

  yearVsAccumulatedMeanFilterFormGroup: FormGroup;
  scoreVsCountFilterFormGroup: FormGroup;
  yearAccumulatedCount = {};

  constructor(
    private banguminUserService: BanguminUserService,
    private bangumiStatsService: BangumiStatsService,
    private bangumiSubjectService: BangumiSubjectService,
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
    this.activatedRoute.parent.parent.params
      .pipe(
        filter(params => params['subjectId']),
        switchMap(params => {
            return this.bangumiSubjectService.getSubject(params['subjectId'], 'small');
          },
        )
      )
      .subscribe(params => {
        this.targetSubject = params;
        this.bangumiStatsService.getSubjectStats(this.targetSubject.id)
          .subscribe(res => {
            if (res) {
              const defaultArr = res.stats;
              // cache stats array
              this.targetSubjectStatsArr = res.stats;
              // initialize filter list value
              this.collectionStatusList = _.map(
                _.uniqBy(defaultArr, 'collectionStatus'), row => CollectionStatusId[row['collectionStatus']]
              );
              // initialize filter form groups
              this.yearVsAccumulatedMeanFilterFormGroup.get('stateSelect').setValue(this.collectionStatusList);
              this.scoreVsCountFilterFormGroup.get('stateSelect').setValue(this.collectionStatusList);

              // this.initScoreVsCount();
              this.initYearVsAccumulatedMean();
            }
          });
      });
  }

  getAccumulatedYearCount(year) {
    return this.yearAccumulatedCount[year];
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

  private initYearVsAccumulatedMean() {
    // initialize the chart with all types
    // const selectedTypeListForyearVsMean = this.yearVsAccumulatedMeanFilterFormGroup.value.subjectTypeSelect;
    this.refreshYearVsAccumulatedMean(this.targetSubjectStatsArr);

    // edit the chart on change of collection status selection
    this.yearVsAccumulatedMeanFilterFormGroup.controls['stateSelect'].valueChanges
      .subscribe(newStateList => {
        const newArr = this.targetSubjectStatsArr
          .filter(stat => newStateList.includes(CollectionStatusId[stat.collectionStatus]));
        // refresh count array
        this.yearAccumulatedCount = [];
        this.refreshYearVsAccumulatedMean(newArr);
      });
  }

  private refreshYearVsAccumulatedMean(newYearVsAccumulatedMeanData) {
    this.yearVsAccumulatedMeanData = [];
    this.groupAndCountByYear(newYearVsAccumulatedMeanData);
  }

  private initScoreVsCount() {
    const arr = this.filterBySubjectTypeAndState(
      this.scoreVsCountFilterFormGroup.value.subjectTypeSelect,
      this.scoreVsCountFilterFormGroup.value.stateSelect
    );
    this.groupAndCountByRate(arr);

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
    this.yearVsAccumulatedMeanFilterFormGroup = this.formBuilder.group(
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

  private groupAndCountByYear(arr) {
    const arrByYear = _.groupBy(arr, (row) => {
      return day(row.addDate).year();
    });
    const yearArr = this.getYearArr(_.min(Object.keys(arrByYear)), _.max(Object.keys(arrByYear)));
    yearArr.forEach(row => {
      // have to consider year with no data, since we are storing accumulated data
      let tmpArr = arrByYear[row.name] || [];
      tmpArr = _.reject(tmpArr, (thisRow) => !thisRow.rate);
      // note down the yearAccumulatedCount
      this.yearAccumulatedCount[row.name] = (this.yearAccumulatedCount[row.name - 1] || 0) + tmpArr.length;
      const curMean = (tmpArr.length === 0) ? 0 : _.meanBy(tmpArr, 'rate');
      const prevYearData = _.filter(yearArr, tmp => tmp.name === (row.name - 1));
      const prevAccumulatedMean = (prevYearData.length === 0) ? 0 : prevYearData[0].value;
      const prevAccumulatedCount = this.yearAccumulatedCount[row.name - 1] || 0;
      const curAccumulatedCount = tmpArr.length + prevAccumulatedCount;
      row.value = (curAccumulatedCount === 0) ? 0 :
        ((curMean * tmpArr.length
          + prevAccumulatedCount * prevAccumulatedMean) / curAccumulatedCount);
    });
    this.yearVsAccumulatedMeanData = [{name: this.targetSubject.subjectName.preferred, series: yearArr}];
  }

  private getYearArr(minYear, maxYear) {
    return _.range(+minYear, (+maxYear + 1)).map((year) => ({name: year, value: 0}));
  }

}
