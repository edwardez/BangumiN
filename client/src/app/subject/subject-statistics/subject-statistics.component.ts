import {Component, OnInit, ViewEncapsulation} from '@angular/core';
import {FormBuilder, FormGroup} from '@angular/forms';
import {BanguminUserService} from '../../shared/services/bangumin/bangumin-user.service';
import {BangumiStatsService} from '../../shared/services/bangumi/bangumi-stats.service';
import {ActivatedRoute} from '@angular/router';
import _countBy from 'lodash/countBy';
import _difference from 'lodash/difference';
import _groupBy from 'lodash/groupBy';
import _map from 'lodash/map';
import _max from 'lodash/max';
import _meanBy from 'lodash/meanBy';
import _min from 'lodash/min';
import _reject from 'lodash/reject';
import _range from 'lodash/range';
import _uniqBy from 'lodash/uniqBy';
import {CollectionStatusId} from '../../shared/enums/collection-status-id';
import * as day from 'dayjs';
import {filter, switchMap} from 'rxjs/operators';
import {BangumiSubjectService} from '../../shared/services/bangumi/bangumi-subject.service';
import {TranslateService} from '@ngx-translate/core';
import {forkJoin} from 'rxjs';
import {RecordSchema} from '../../shared/models/stats/record-schema';

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

  lastUpdateTime: number;
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
          const defaultArr = res[1].stats as RecordSchema[];
          this.lastUpdateTime = res[1].lastModified;
          const translatedStatusFullName = res[2];
          // cache stats array
          this.targetSubjectStatsArr = res[1].stats;
          this.countByStateData = _map(
            _countBy(defaultArr, 'collectionStatus'),
            (val, key) => ({name: translatedStatusFullName[CollectionStatusId[key]], value: val})
          );
          // initialize filter list value
          this.collectionStatusList = _map(
            _uniqBy(defaultArr, 'collectionStatus'), row => CollectionStatusId[row['collectionStatus']]
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

  getLastUpdateTime() {
    return this.bangumiStatsService.getLastUpdateTime(this.lastUpdateTime);
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

  private refreshDescStat(subjectStat: any[]) {
    this.bangumiStatsService.calculateDescriptiveChartData(subjectStat).subscribe(descStatData => {
      this.descStatData = descStatData;
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
    let countedArr = _map(_countBy(arr, 'rate'), (val, key) => ({name: key, value: val}));
    const diff = _difference(xAxisTicks, countedArr.map(t => t.name));
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
    const arrByYear = _groupBy(arr, (row) => {
      return day(row.addDate).year();
    });
    const yearArr = this.getYearArr(_min(Object.keys(arrByYear)), _max(Object.keys(arrByYear)));
    yearArr.forEach(row => {
      // have to consider year with no data, since we are storing accumulated data
      let tmpArr = arrByYear[row.name] || [];
      tmpArr = _reject(tmpArr, (thisRow) => !thisRow.rate);
      // note down the yearAccumulatedCount
      this.yearAccumulatedCount[row.name] = (this.yearAccumulatedCount[row.name - 1] || 0) + tmpArr.length;
      const curMean = (tmpArr.length === 0) ? 0 : _meanBy(tmpArr, 'rate');
      const prevYearData = yearArr.filter(tmp => tmp.name === (row.name - 1));
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
    return _range(+minYear, (+maxYear + 1)).map((year) => ({name: year, value: 0}));
  }

}
