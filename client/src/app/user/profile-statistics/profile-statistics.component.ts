import {Component, OnDestroy, OnInit} from '@angular/core';
import * as _ from 'lodash';
import * as day from 'dayjs';
import {take, takeUntil} from 'rxjs/operators';
import {BanguminUserService} from '../../shared/services/bangumin/bangumin-user.service';
import {BangumiStatsService} from '../../shared/services/bangumi/bangumi-stats.service';
import {ActivatedRoute} from '@angular/router';
import {SubjectType} from '../../shared/enums/subject-type.enum';
import {CollectionStatusId} from '../../shared/enums/collection-status-id';
import {FormBuilder, FormGroup} from '@angular/forms';
import {Subject} from 'rxjs';
import {BangumiUserService} from '../../shared/services/bangumi/bangumi-user.service';
import {BangumiUser} from '../../shared/models/BangumiUser';
import {TitleService} from '../../shared/services/page/title.service';
import {TranslateService} from '@ngx-translate/core';

@Component({
  selector: 'app-profile-stats',
  templateUrl: './profile-statistics.component.html',
  styleUrls: ['./profile-statistics.component.scss']
})
export class ProfileStatisticsComponent implements OnInit, OnDestroy {
  // todo: options for each chart
  colorScheme;
  scoreVsCountData;

  // if user has no record under some subject type, that type won't be included
  userCurrentSubjectTypeList;
  // all subject types on Bangumi
  readonly allValidSubjectTypeList: string[] = Object.keys(SubjectType).filter(k => isNaN(Number(k)));
  // if user has no status record(i.e. user never drops subject), that status won't be included
  collectionStatusList;
  // all collection status types on Bangumi
  readonly allValidCollectionStatusList: string[] = Object.keys(CollectionStatusId).filter(k => isNaN(Number(k)));
  selectedTypeListForscoreVsCount;

  rangeFillOpacity = 0.15;
  schemeType = 'ordinal';
  yearVsMeanData = [];
  // triggerValue;

  countByTypeData;
  // mean, median, stdDev
  descStatData;

  targetUser: BangumiUser;
  // raw data - CONST!
  targetUserStatsArr;

  descStatFilterFormGroup: FormGroup;
  yearVsMeanFilterFormGroup: FormGroup;
  scoreVsCountFilterFormGroup: FormGroup;
  yearCount = {};

  private ngUnsubscribe: Subject<void> = new Subject<void>();

  constructor(
    private activatedRoute: ActivatedRoute,
    private bangumiUserService: BangumiUserService,
    private banguminUserService: BanguminUserService,
    private bangumiStatsService: BangumiStatsService,
    private formBuilder: FormBuilder,
    private titleService: TitleService,
    private translateService: TranslateService
  ) {
    this.colorScheme = {
      domain: ['#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00']
    };

    this.selectedTypeListForscoreVsCount = this.userCurrentSubjectTypeList;

    this.initStatsFormGroup();
  }

  get AllSubjectTypes() {
    return Object.keys(SubjectType).filter(k => isNaN(Number(k)));
  }

  get AllCollectionStatuses() {
    return Object.keys(CollectionStatusId).filter(k => isNaN(Number(k)));
  }

  ngOnDestroy(): void {
    // unsubscribe, we can also first() in subscription
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

  getYearCount(year) {
    return this.yearCount[year];
  }

  ngOnInit() {
    this.banguminUserService.getUserSettings()
      .pipe(
        take(1)
      ).subscribe(settings => {
    });

    this.activatedRoute.parent.params
      .subscribe(params => {
        const targetUserId = params['userId'];
        this.getUserProfile(targetUserId);
        this.bangumiStatsService.getUserStats(targetUserId)
          .subscribe(res => {
            if (res) {
              const defaultArr = res.stats;
              // cache stats array
              this.targetUserStatsArr = res.stats;
              this.countByTypeData = _.map(_.countBy(defaultArr, 'subjectType'), (val, key) => ({name: SubjectType[key], value: val}));
              // initialize filter list value
              this.userCurrentSubjectTypeList = _.map(this.countByTypeData, 'name');
              this.collectionStatusList = _.map(
                _.uniqBy(defaultArr, 'collectionStatus'), row => CollectionStatusId[row['collectionStatus']]
              );
              // initialize filter form groups
              this.descStatFilterFormGroup.get('subjectTypeSelect').setValue(this.userCurrentSubjectTypeList);
              this.descStatFilterFormGroup.get('stateSelect').setValue(this.collectionStatusList);
              this.yearVsMeanFilterFormGroup.get('subjectTypeSelect').setValue(this.userCurrentSubjectTypeList);
              this.yearVsMeanFilterFormGroup.get('stateSelect').setValue(this.collectionStatusList);
              this.scoreVsCountFilterFormGroup.get('subjectTypeSelect').setValue(this.userCurrentSubjectTypeList);
              this.scoreVsCountFilterFormGroup.get('stateSelect').setValue(this.collectionStatusList);

              this.initDescStat();
              this.initScoreVsCount();
              this.initYearVsMean();
            }
          });
      });
  }

  pieTooltipVariables({data}) {
    const pieSegmentName = data.name;
    const pieSegmentValue = data.value;

    return {pieSegmentName, pieSegmentValue};
  }

  private initYearVsMean() {
    // initialize the chart with all types
    const selectedTypeListForyearVsMean = this.yearVsMeanFilterFormGroup.value.subjectTypeSelect;
    this.refreshYearVsMean(this.targetUserStatsArr, selectedTypeListForyearVsMean);

    // edit the chart on change of subjectType selection
    // use formControl.valueChanges instead of selectionChange since we want to modify the chart minimally,
    // i.e. instead of re-filtering the whole array with selectedList, only add/remove target subjectType from the chart.
    this.yearVsMeanFilterFormGroup.controls['subjectTypeSelect'].valueChanges
      .pipe(
        takeUntil(this.ngUnsubscribe)
      )
      .subscribe(newVal => {
        const oldVal = this.yearVsMeanFilterFormGroup.value.subjectTypeSelect;
        const triggerValue = (newVal.length < oldVal.length) ?
          _.difference(oldVal, newVal)[0] as string : _.difference(newVal, oldVal)[0] as string;
        const action = (newVal.length < oldVal.length) ? 'deSelect' : 'select';
        // selected a value
        if (action === 'select') {
          const thisTypeArr = this.targetUserStatsArr
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
      .pipe(
        takeUntil(this.ngUnsubscribe)
      )
      .subscribe(newStateList => {
        const newArr = this.targetUserStatsArr
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
      .pipe(
        takeUntil(this.ngUnsubscribe)
      )
      .subscribe(newTypeList => {
        const newArr = this.filterBySubjectTypeAndState(
          newTypeList,
          this.scoreVsCountFilterFormGroup.value.stateSelect
        );
        this.groupAndCountByRate(newArr);
      });

    // edit the chart on change of collection status selection
    this.scoreVsCountFilterFormGroup.controls['stateSelect'].valueChanges
      .pipe(
        takeUntil(this.ngUnsubscribe)
      )
      .subscribe(newStateList => {
        const newArr = this.filterBySubjectTypeAndState(
          this.scoreVsCountFilterFormGroup.value.subjectTypeSelect,
          newStateList
        );
        this.groupAndCountByRate(newArr);
      });
  }

  private filterBySubjectTypeAndState(subjectTypeList, stateList) {
    return this.targetUserStatsArr.filter(stat => {
      return subjectTypeList.includes(SubjectType[stat.subjectType])
        && stateList.includes(CollectionStatusId[stat.collectionStatus]);
    });
  }

  calendarAxisTickFormatting(year) {
    if (Math.floor(year) !== year) {
      return '';
    }
    return day().set('year', year).year();
  }

  private initDescStat() {
    const arr = this.filterBySubjectTypeAndState(
      this.descStatFilterFormGroup.value.subjectTypeSelect,
      this.descStatFilterFormGroup.value.stateSelect
    );
    this.refreshDescStat(arr);

    // edit the number cards on change of subjectType selection
    this.descStatFilterFormGroup.controls['subjectTypeSelect'].valueChanges
      .subscribe(newTypeList => {
        const newArr = this.filterBySubjectTypeAndState(
          newTypeList,
          this.descStatFilterFormGroup.value.stateSelect
        );
        this.refreshDescStat(newArr);
      });

    // edit the number cards on change of collection status selection
    this.descStatFilterFormGroup.controls['stateSelect'].valueChanges
      .subscribe(newStateList => {
        const newArr = this.filterBySubjectTypeAndState(
          this.descStatFilterFormGroup.value.subjectTypeSelect,
          newStateList
        );
        this.refreshDescStat(newArr);
      });
  }

  getYearScoreMinMax(subjectType, year, minMax) {
    const typeArr = _.filter(this.yearVsMeanData, row => row.name === subjectType);
    const yearArr = _.filter(typeArr[0].series, row => row.name === year);
    return yearArr[0][minMax];
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
        subjectTypeSelect: [[]],
        stateSelect: [[]]
      }
    );

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

  private getUserProfile(userId: string) {
    this.bangumiUserService.getUserInfoFromHttp(userId).subscribe(bangumiUser => {
      this.targetUser = bangumiUser;
      this.titleService.setTitleByTranslationLabel('statistics.headline', {name: this.targetUser.nickname});
    });
  }

}
