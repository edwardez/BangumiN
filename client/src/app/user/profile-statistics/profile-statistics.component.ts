import {Component, OnDestroy, OnInit} from '@angular/core';
import _countBy from 'lodash/countBy';
import _difference from 'lodash/difference';
import _groupBy from 'lodash/groupBy';
import _isEmpty from 'lodash/isEmpty';
import _map from 'lodash/map';
import _uniqBy from 'lodash/uniqBy';
import {takeUntil} from 'rxjs/operators';
import {BanguminUserService} from '../../shared/services/bangumin/bangumin-user.service';
import {AccumulatedMeanDataSchema, BangumiStatsService} from '../../shared/services/bangumi/bangumi-stats.service';
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
import {curveBasis} from 'd3-shape';


@Component({
  selector: 'app-profile-stats',
  templateUrl: './profile-statistics.component.html',
  styleUrls: ['./profile-statistics.component.scss']
})
export class ProfileStatisticsComponent implements OnInit, OnDestroy {
  colorScheme = BangumiStatsService.colorScheme;
  lineCurveType = curveBasis;
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

  accumulatedMeanData: AccumulatedMeanDataSchema[] = [];

  countByTypeDataTranslated;
  // mean, median, stdDev
  descStatData;

  targetUser: BangumiUser;
  // raw data - CONST!
  targetUserStatsArr: RecordSchema[];

  descStatFilterFormGroup: FormGroup;
  accumulatedMeanFilterFormGroup: FormGroup;
  scoreVsCountFilterFormGroup: FormGroup;
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
    this.selectedTypeListForscoreVsCount = this.userCurrentSubjectTypeList;
    this.initStatsFormGroup();
  }

  ngOnDestroy(): void {
    // unsubscribe, we can also first() in subscription
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

  ngOnInit() {
    this.activatedRoute.parent.params
      .subscribe(params => {
        this.ngUnsubscribe.next();
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
            this.accumulatedMeanFilterFormGroup.get('subjectTypeSelect').setValue(this.userCurrentSubjectTypeList);
            this.accumulatedMeanFilterFormGroup.get('stateSelect').setValue(this.collectionStatusList);
            this.scoreVsCountFilterFormGroup.get('subjectTypeSelect').setValue(this.userCurrentSubjectTypeList);
            this.scoreVsCountFilterFormGroup.get('stateSelect').setValue(this.collectionStatusList);

            this.initDescStat();
            this.initScoreVsCount();
            this.initAccumulatedMean();
          }
        });
      });
  }

  pieTooltipVariables({data}) {
    const pieSegmentName = data.name;
    const pieSegmentValue = data.value;

    return {pieSegmentName, pieSegmentValue};
  }

  formatDateToSimpleString(addedAt: Date) {
    return BangumiStatsService.formatDateToSimpleString(addedAt);
  }

  getLastUpdateTime() {
    return this.bangumiStatsService.getLastUpdateTime(this.lastUpdateTime);
  }

  /**
   * Get count of score for a user until a specific pointTime
   */
  getScoringCountUntil(accumulatedMeanData: AccumulatedMeanDataSchema[], lineType: string, pointTime: Date) {
    return BangumiStatsService.getScoringCountUntil(accumulatedMeanData, lineType, pointTime);
  }

  calendarAxisTickFormatting(addedAt: Date) {
    return BangumiStatsService.formatDateToSimpleString(addedAt);
  }

  formatStateData(percentage) {
    return BangumiStatsService.formatFloatingPoint(percentage);
  }


  private initAccumulatedMean() {
    // initialize the chart with all types
    const selectedTypeListForaccumulatedMean = this.accumulatedMeanFilterFormGroup.value.subjectTypeSelect;
    this.refreshAccumulatedMean(this.targetUserStatsArr, selectedTypeListForaccumulatedMean);

    // edit the chart on change of subjectType selection
    // use formControl.valueChanges instead of selectionChange since we want to modify the chart minimally,
    // i.e. instead of re-filtering the whole array with selectedList, only add/remove target subjectType from the chart.
    this.accumulatedMeanFilterFormGroup.controls['subjectTypeSelect'].valueChanges
      .pipe(
        takeUntil(this.ngUnsubscribe)
      )
      .subscribe(newVal => {
        const oldVal = this.accumulatedMeanFilterFormGroup.value.subjectTypeSelect;
        const triggerValue = (newVal.length < oldVal.length) ?
          _difference(oldVal, newVal)[0] as string : _difference(newVal, oldVal)[0] as string;
        const action = (newVal.length < oldVal.length) ? 'deSelect' : 'select';
        // selected a value
        if (action === 'select') {
          const currentStateList = this.accumulatedMeanFilterFormGroup.value.stateSelect;
          const thisTypeArr = this.targetUserStatsArr
            .filter((stat) => (SubjectType[stat.subjectType] === triggerValue &&
              currentStateList.includes(CollectionStatusId[stat.collectionStatus])));
          this.calculatedAccumulatedMeanPoints(thisTypeArr, triggerValue);
        } else {
          // deselected a value
          const newArr = this.accumulatedMeanData.filter((row) => {
            // convert changed type into user's language for comparison
            return row.name !== this.localTranslatedSubjectType[triggerValue];
          });
          this.accumulatedMeanData = [...newArr];
        }
      });

    // edit the chart on change of collection status selection
    this.accumulatedMeanFilterFormGroup.controls['stateSelect'].valueChanges
      .pipe(
        takeUntil(this.ngUnsubscribe)
      )
      .subscribe(newStateList => {
        const newArr = this.targetUserStatsArr
          .filter(stat => newStateList.includes(CollectionStatusId[stat.collectionStatus]));
        this.refreshAccumulatedMean(newArr, this.accumulatedMeanFilterFormGroup.value.subjectTypeSelect);
      });
  }

  private refreshAccumulatedMean(newAccumulatedMeanData, selectedTypeList) {
    this.accumulatedMeanData = [];
    const arr = newAccumulatedMeanData
      .filter(stat => selectedTypeList.includes(SubjectType[stat.subjectType]));
    const arrByType = _groupBy(arr, (row) => {
      return SubjectType[row.subjectType];
    });
    Object.keys(arrByType).forEach((type) => {
      this.calculatedAccumulatedMeanPoints(arrByType[type], type);
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
      .pipe(
        takeUntil(this.ngUnsubscribe)
      )
      .subscribe(newTypeList => {
        const newArr = this.filterBySubjectTypeAndState(
          newTypeList,
          this.descStatFilterFormGroup.value.stateSelect
        );
        this.refreshDescStat(newArr);
      });

    // edit the number cards on change of collection status selection
    this.descStatFilterFormGroup.controls['stateSelect'].valueChanges
      .pipe(
        takeUntil(this.ngUnsubscribe)
      )
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

    this.accumulatedMeanFilterFormGroup = this.formBuilder.group(
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

  private calculatedAccumulatedMeanPoints(allRecords: { collectionStatus: number, addDate: number, addedAt: Date, rate: number }[],
                                          type: string) {
    const accumulatedMeanPoints = BangumiStatsService.calculateAccumulatedMean(allRecords);
    if (!_isEmpty(accumulatedMeanPoints)) {
      this.accumulatedMeanData = [...this.accumulatedMeanData,
        {name: this.localTranslatedSubjectType[type], series: accumulatedMeanPoints}];
    }
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
