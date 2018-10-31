import {Component, OnDestroy, OnInit, ViewEncapsulation} from '@angular/core';
import {FormBuilder, FormGroup} from '@angular/forms';
import {BanguminUserService} from '../../shared/services/bangumin/bangumin-user.service';
import {AccumulatedMeanDataSchema, BangumiStatsService} from '../../shared/services/bangumi/bangumi-stats.service';
import {ActivatedRoute} from '@angular/router';
import _countBy from 'lodash/countBy';
import _map from 'lodash/map';
import _uniqBy from 'lodash/uniqBy';
import {curveBasis} from 'd3-shape';
import {CollectionStatusId} from '../../shared/enums/collection-status-id';
import {filter, switchMap, takeUntil} from 'rxjs/operators';
import {BangumiSubjectService} from '../../shared/services/bangumi/bangumi-subject.service';
import {TranslateService} from '@ngx-translate/core';
import {forkJoin, Subject} from 'rxjs';
import {RecordSchema} from '../../shared/models/stats/record-schema';

@Component({
  selector: 'app-subject-statistics',
  templateUrl: './subject-statistics.component.html',
  styleUrls: ['./subject-statistics.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class SubjectStatisticsComponent implements OnInit, OnDestroy {
  colorScheme = BangumiStatsService.colorScheme;
  lineCurveType = curveBasis;
  scoreVsCountData;

  collectionStatusList;
  countByStateData;
  descStatData;

  accumulatedMeanData = [];
  // triggerValue;

  targetSubject;
  // raw data - CONST!
  targetSubjectStatsArr;

  lastUpdateTime: number;
  descStatFilterFormGroup: FormGroup;
  accumulatedMeanFilterFormGroup: FormGroup;
  scoreVsCountFilterFormGroup: FormGroup;

  private ngUnsubscribe: Subject<void> = new Subject<void>();

  constructor(
    private activatedRoute: ActivatedRoute,
    private banguminUserService: BanguminUserService,
    private bangumiStatsService: BangumiStatsService,
    private bangumiSubjectService: BangumiSubjectService,
    private formBuilder: FormBuilder,
    private translateService: TranslateService,
  ) {
  }

  ngOnInit() {
    this.initStatsFormGroup();
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
        this.ngUnsubscribe.next();
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
          this.accumulatedMeanFilterFormGroup.get('stateSelect').setValue(this.collectionStatusList);
          this.scoreVsCountFilterFormGroup.get('stateSelect').setValue(this.collectionStatusList);

          this.initDescStat();
          this.initScoreVsCount();
          this.initAccumulatedMean();
        }
      });
  }

  ngOnDestroy(): void {
    // unsubscribe, we can also first() in subscription
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

  /**
   * Get count of score for a user until a specific pointTime
   */
  getScoringCountUntil(accumulatedMeanData: AccumulatedMeanDataSchema[], lineType: string, pointTime: Date) {
    return BangumiStatsService.getScoringCountUntil(accumulatedMeanData, lineType, pointTime);
  }

  formatDateToSimpleString(addedAt: Date) {
    return BangumiStatsService.formatDateToSimpleString(addedAt);
  }

  pieTooltipText({data}) {
    const label = data.name;
    const val = data.value;

    return `
      <span class="tooltip-label">${label}</span>
      <span class="tooltip-val">${val}</span>
    `;
  }

  formatStateData(percentage) {
    return BangumiStatsService.formatFloatingPoint(percentage);
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
      .pipe(
        takeUntil(this.ngUnsubscribe)
      )
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

  private initAccumulatedMean() {
    // initialize the chart with all types
    this.refreshAccumulatedMean(this.targetSubjectStatsArr);

    // edit the chart on change of collection status selection
    this.accumulatedMeanFilterFormGroup.controls['stateSelect'].valueChanges
      .pipe(
        takeUntil(this.ngUnsubscribe)
      )
      .subscribe(newStateList => {
        const newArr = this.targetSubjectStatsArr
          .filter(stat => newStateList.includes(CollectionStatusId[stat.collectionStatus]));
        this.refreshAccumulatedMean(newArr);
      });
  }

  private refreshAccumulatedMean(newAccumulatedMeanData) {
    this.accumulatedMeanData = [];
    this.calculateAccumulatedMeanPoints(newAccumulatedMeanData);
  }

  private initScoreVsCount() {
    const arr = this.filterByState(this.scoreVsCountFilterFormGroup.value.stateSelect);
    this.groupAndCountByRate(arr);

    // edit the chart on change of collection status selection
    this.scoreVsCountFilterFormGroup.controls['stateSelect'].valueChanges
      .pipe(
        takeUntil(this.ngUnsubscribe)
      )
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
    this.scoreVsCountData = this.bangumiStatsService.groupAndCountByRate(newScoreVsCountData);
  }

  private initStatsFormGroup() {
    this.descStatFilterFormGroup = this.formBuilder.group(
      {
        stateSelect: [[]]
      }
    );

    this.accumulatedMeanFilterFormGroup = this.formBuilder.group(
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

  private calculateAccumulatedMeanPoints(allRecords: { collectionStatus: number, addDate: number, addedAt: Date, rate: number }[]) {
    this.accumulatedMeanData =
      [{name: this.targetSubject.subjectName.preferred, series: BangumiStatsService.calculateAccumulatedMean(allRecords)}];
  }

}
