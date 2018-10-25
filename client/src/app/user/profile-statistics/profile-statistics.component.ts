import {Component, OnDestroy, OnInit} from '@angular/core';
import _countBy from 'lodash/countBy';
import _difference from 'lodash/difference';
import _groupBy from 'lodash/groupBy';
import _map from 'lodash/map';
import _max from 'lodash/max';
import _maxBy from 'lodash/maxBy';
import _meanBy from 'lodash/meanBy';
import _min from 'lodash/min';
import _minBy from 'lodash/minBy';
import _reject from 'lodash/reject';
import _range from 'lodash/range';
import _uniqBy from 'lodash/uniqBy';
import * as day from 'dayjs';
import {takeUntil} from 'rxjs/operators';
import {BanguminUserService} from '../../shared/services/bangumin/bangumin-user.service';
import {BangumiStatsService} from '../../shared/services/bangumi/bangumi-stats.service';
import {ActivatedRoute} from '@angular/router';
import {SubjectType} from '../../shared/enums/subject-type.enum';
import {CollectionStatusId} from '../../shared/enums/collection-status-id';
import {FormBuilder, FormGroup} from '@angular/forms';
import {forkJoin, Subject} from 'rxjs';
import {BangumiUserService} from '../../shared/services/bangumi/bangumi-user.service';
import {BangumiUser} from '../../shared/models/BangumiUser';
import {TitleService} from '../../shared/services/page/title.service';
import {TranslateService} from '@ngx-translate/core';
import {RecordSchema} from '../../shared/models/stats/record-schema';

@Component({
  selector: 'app-profile-stats',
  templateUrl: './profile-statistics.component.html',
  styleUrls: ['./profile-statistics.component.scss']
})
export class ProfileStatisticsComponent implements OnInit, OnDestroy {
  // todo: options for each chart
  colorScheme = BangumiStatsService.colorScheme;
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

  yearVsMeanData = [];
  // triggerValue;

  countByTypeDataTranslated;
  // mean, median, stdDev
  descStatData;

  targetUser: BangumiUser;
  // raw data - CONST!
  targetUserStatsArr;

  descStatFilterFormGroup: FormGroup;
  yearVsMeanFilterFormGroup: FormGroup;
  scoreVsCountFilterFormGroup: FormGroup;
  yearCount = {};
  localTranslatedSubjectType;
  lastUpdateTime: number;

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
    this.colorScheme = BangumiStatsService.colorScheme;

    this.selectedTypeListForscoreVsCount = this.userCurrentSubjectTypeList;

    this.initStatsFormGroup();
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
    this.activatedRoute.parent.params
      .subscribe(params => {
        const targetUserId = params['userId'];
        this.getUserProfile(targetUserId);
        forkJoin([
          this.translateService.get('common.category'),
          this.bangumiStatsService.getUserStats(targetUserId)
        ]).subscribe(response => {
          if (response[0]) {
            this.localTranslatedSubjectType = response[0];
          }

          if (response[1]) {
            const res = response[1];
            const defaultArr = res.stats as RecordSchema[];
            this.lastUpdateTime = res.lastModified;
            // cache stats array
            this.targetUserStatsArr = res.stats;
            this.countByTypeDataTranslated = _map(_countBy(defaultArr, 'subjectType'),
              (val, key) => ({name: this.localTranslatedSubjectType[SubjectType[key]], value: val}));
            const countByTypeDataRaw = _map(_countBy(defaultArr, 'subjectType'), (val, key) => ({name: SubjectType[key], value: val}));
            // initialize filter list value
            this.userCurrentSubjectTypeList = countByTypeDataRaw.map(typeData => typeData['name']);
            this.collectionStatusList = _uniqBy(defaultArr, 'collectionStatus').map(
              row => CollectionStatusId[row['collectionStatus']]
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

  getLastUpdateTime() {
    return this.bangumiStatsService.getLastUpdateTime(this.lastUpdateTime);
  }

  calendarAxisTickFormatting(year) {
    if (Math.floor(year) !== year) {
      return '';
    }
    return day().set('year', year).year();
  }

  getYearScoreMinMax(subjectType, year, minMax) {
    const typeArr = this.yearVsMeanData.filter(row => row.name === subjectType);
    const yearArr = typeArr[0].series.filter(row => row.name === year);
    return yearArr[0][minMax];
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
          _difference(oldVal, newVal)[0] as string : _difference(newVal, oldVal)[0] as string;
        const action = (newVal.length < oldVal.length) ? 'deSelect' : 'select';
        // selected a value
        if (action === 'select') {
          const thisTypeArr = this.targetUserStatsArr
            .filter((stat) => (SubjectType[stat.subjectType] === triggerValue));
          this.groupAndCountByYearOfType(thisTypeArr, triggerValue);
        } else {
          // deselected a value
          const newArr = this.yearVsMeanData.filter((row) => {
            // convert changed type into user's language for comparison
            return row.name !== this.localTranslatedSubjectType[triggerValue];
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
    const arrByType = _groupBy(arr, (row) => {
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

  private groupAndCountByRate(newScoreVsCountData) {
    this.scoreVsCountData = this.bangumiStatsService.groupAndCountByRate(newScoreVsCountData);
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
    const arrByYear = _groupBy(arr, (row) => {
      return day(row.addDate).year();
    });
    const yearArr = this.getYearArr(_min(Object.keys(arrByYear)), _max(Object.keys(arrByYear)));
    yearArr.forEach(row => {
      let tmpArr = arrByYear[row.name];
      if (tmpArr) {
        row.min = (_minBy(tmpArr, 'rate')) ? +_minBy(tmpArr, 'rate').rate : 0;
        row.max = (_maxBy(tmpArr, 'rate')) ? +_maxBy(tmpArr, 'rate').rate : 0;
        tmpArr = _reject(tmpArr, (thisRow) => !thisRow.rate);
        // note down the yearCount
        this.yearCount[row.name] = tmpArr.length;
        row.value = (tmpArr.length === 0) ? 0 : _meanBy(tmpArr, 'rate');
      }
    });
    // translate subjectType into user's language
    this.yearVsMeanData = [...this.yearVsMeanData, {name: this.localTranslatedSubjectType[type], series: yearArr}];
  }

  private getYearArr(minYear, maxYear) {
    return _range(+minYear, (+maxYear + 1)).map((year) => ({name: year, value: 0, min: 0, max: 0}));
  }

  private refreshDescStat(subjectStat: any[]) {
    this.bangumiStatsService.calculateDescriptiveChartData(subjectStat).subscribe(descStatData => {
      this.descStatData = descStatData;
    });
  }

  private getUserProfile(userId: string) {
    this.bangumiUserService.getUserInfoFromHttp(userId).subscribe(bangumiUser => {
      this.targetUser = bangumiUser;
      this.titleService.setTitleByTranslationLabel('statistics.headline', {name: this.targetUser.nickname});
    });
  }

}
