import {Component, OnInit, ViewEncapsulation} from '@angular/core';
import {FormBuilder, FormGroup} from '@angular/forms';
import {BanguminUserService} from '../../shared/services/bangumin/bangumin-user.service';
import {BangumiStatsService} from '../../shared/services/bangumi/bangumi-stats.service';
import {ActivatedRoute} from '@angular/router';
import * as _ from 'lodash';
import {CollectionStatusId} from '../../shared/enums/collection-status-id';
import * as day from 'dayjs';
import {filter, switchMap} from 'rxjs/operators';
import {BangumiSubjectService} from '../../shared/services/bangumi/bangumi-subject.service';
import {TranslateService} from '@ngx-translate/core';
import {forkJoin} from 'rxjs';

@Component({
  selector: 'app-subject-statistics',
  templateUrl: './subject-statistics.component.html',
  styleUrls: ['./subject-statistics.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class SubjectStatisticsComponent implements OnInit {
  // todo: options for each chart
  xAxisLabel;
  yAxisLabel;
  colorScheme;
  scoreVsCountData;

  collectionStatusList;
  countByStateData;
  descStatData;

  rangeFillOpacity = 0.15;
  schemeType = 'ordinal';
  yearVsAccumulatedMeanData = [];
  // triggerValue;

  targetSubject;
  // raw data - CONST!
  targetSubjectStatsArr;

  descStatFilterFormGroup: FormGroup;
  yearVsAccumulatedMeanFilterFormGroup: FormGroup;
  scoreVsCountFilterFormGroup: FormGroup;
  yearAccumulatedCount = {};

  constructor(
    private activatedRoute: ActivatedRoute,
    private banguminUserService: BanguminUserService,
    private bangumiStatsService: BangumiStatsService,
    private bangumiSubjectService: BangumiSubjectService,
    private formBuilder: FormBuilder,
    private translateService: TranslateService,
  ) {
    // todo: translate legend and label
    this.xAxisLabel = 'Score';
    this.yAxisLabel = 'Count';

    this.colorScheme = {
      domain: ['#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00']
    };

    this.initStatsFormGroup();
  }

  ngOnInit() {
    this.activatedRoute.parent.parent.params
      .pipe(
        filter(params => params['subjectId']),
        switchMap(params => {
          const subjectId = params['subjectId'];
          return forkJoin([this.bangumiSubjectService.getSubject(subjectId, 'small'), this.bangumiStatsService.getSubjectStats(subjectId),
            this.translateService.get('common.statusFullname')]);
        }),
      )
      .subscribe(res => {
        if (res) {
          this.targetSubject = res[0];
          const defaultArr = res[1].stats;
          const translatedStatusFullName = res[2];
          // cache stats array
          this.targetSubjectStatsArr = res[1].stats;
          this.countByStateData = _.map(
            _.countBy(defaultArr, 'collectionStatus'),
            (val, key) => ({name: translatedStatusFullName[CollectionStatusId[key]], value: val})
          );
          // initialize filter list value
          this.collectionStatusList = _.map(
            _.uniqBy(defaultArr, 'collectionStatus'), row => CollectionStatusId[row['collectionStatus']]
          );
          // initialize filter form groups
          this.descStatFilterFormGroup.get('stateSelect').setValue(this.collectionStatusList);
          this.yearVsAccumulatedMeanFilterFormGroup.get('stateSelect').setValue(this.collectionStatusList);
          this.scoreVsCountFilterFormGroup.get('stateSelect').setValue(this.collectionStatusList);

          this.initDescStat();
          this.initScoreVsCount();
          this.initYearVsAccumulatedMean();
        }
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

  private initDescStat() {
    const arr = this.filterByState(
      this.descStatFilterFormGroup.value.stateSelect
    );
    this.refreshDescStat(arr);

    // edit the number cards on change of collection status selection
    this.descStatFilterFormGroup.controls['stateSelect'].valueChanges
      .subscribe(newStateList => {
        const newArr = this.filterByState(
          newStateList
        );
        this.refreshDescStat(newArr);
      });
  }

  private refreshDescStat(userStat: any[]) {
    // filter null rate
    userStat = userStat.filter(stat => stat.rate);
    const len = userStat.length;
    let mean, median, stdDev;
    if (len === 0) {
      mean = 0;
      median = 0;
      stdDev = 0;
    } else {
      mean = _.meanBy(userStat, 'rate');
      const middle = (len + 1) / 2, sorted = userStat.sort();
      median = (sorted.length % 2) ? sorted[middle - 1].rate : (sorted[middle - 1.5].rate + sorted[middle - 0.5].rate) / 2;
      stdDev = Math.sqrt(_.sum(_.map(userStat, (i) => Math.pow((i.rate - mean), 2))) / len);
    }

    const numberChartNames = ['statistics.descriptiveChart.name.mean', 'statistics.descriptiveChart.name.median',
      'statistics.descriptiveChart.name.standardDeviation'];
    this.translateService.get(numberChartNames).subscribe(res => {
      this.descStatData = [
        {name: res[numberChartNames[0]], value: mean.toFixed(2)},
        {name: res[numberChartNames[1]], value: median},
        {name: res[numberChartNames[2]], value: stdDev.toFixed(2)}
      ];
    });
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
    const arr = this.filterByState(this.scoreVsCountFilterFormGroup.value.stateSelect);
    this.groupAndCountByRate(arr);

    // edit the chart on change of collection status selection
    this.scoreVsCountFilterFormGroup.controls['stateSelect'].valueChanges
      .subscribe(newStateList => {
        const newArr = this.filterByState(newStateList);
        this.groupAndCountByRate(newArr);
      });
  }

  private filterByState(stateList) {
    return this.targetSubjectStatsArr.filter(stat => {
      return stateList.includes(CollectionStatusId[stat.collectionStatus]);
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
    this.descStatFilterFormGroup = this.formBuilder.group(
      {
        stateSelect: [[]]
      }
    );

    this.yearVsAccumulatedMeanFilterFormGroup = this.formBuilder.group(
      {
        stateSelect: [[]]
      }
    );

    this.scoreVsCountFilterFormGroup = this.formBuilder.group(
      {
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
