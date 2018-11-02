import {Component, Input, OnDestroy, OnInit} from '@angular/core';
import {ActivatedRoute} from '@angular/router';
import {BangumiSubjectService} from '../../shared/services/bangumi/bangumi-subject.service';
import {filter, map, switchMap, takeUntil, tap} from 'rxjs/operators';
import {SubjectLarge} from '../../shared/models/subject/subject-large';
import {BangumiCollectionService} from '../../shared/services/bangumi/bangumi-collection.service';
import {TitleService} from '../../shared/services/page/title.service';
import {ReviewDialogData} from '../../shared/models/review/reviewDialogData';
import {DialogConfig, ResponsiveDialogService} from '../../shared/services/dialog/responsive-dialog.service';
import {SubjectType} from '../../shared/enums/subject-type.enum';
import {combineLatest, Subject} from 'rxjs/index';
import {LayoutService} from '../../shared/services/layout/layout.service';
import {SnackBarService} from '../../shared/services/snackBar/snack-bar.service';

import {DeviceWidth} from '../../shared/enums/device-width.enum';
import {ReviewDialogComponent} from '../review-dialog/review-dialog.component';


export enum ReviewDialogInitialState {
  Hidden = 1,
  OpenReviewDialogOnly = 2,
  OpenAndEnableSpoilerFlag = 3,
}

@Component({
  selector: 'app-single-subject',
  templateUrl: './single-subject.component.html',
  styleUrls: ['./single-subject.component.scss']
})
export class SingleSubjectComponent implements OnInit, OnDestroy {

  subject: SubjectLarge;

  currentDeviceWidth: DeviceWidth;

  @Input()
  reviewDialogInitialState = ReviewDialogInitialState.Hidden;

  private ngUnsubscribe: Subject<void> = new Subject<void>();

  constructor(private activatedRoute: ActivatedRoute,
              private bangumiSubjectService: BangumiSubjectService,
              private bangumiCollectionService: BangumiCollectionService,
              private titleService: TitleService,
              private reviewDialogService: ResponsiveDialogService,
              private layoutService: LayoutService,
              private snackBarService: SnackBarService
  ) {
  }

  get SubjectType() {
    return SubjectType;
  }

  get LayoutService() {
    return LayoutService;
  }


  ngOnInit() {
    this.ngUnsubscribe.next();
    this.getDeviceWidth();
    this.activatedRoute.params
      .pipe(
        tap(console.log),
        filter(params => !!params['subjectId']),
        switchMap(params => {

            return this.bangumiSubjectService.getSubject(params['subjectId'], 'large');
          },
        ),
        takeUntil(this.ngUnsubscribe),
      )
      .subscribe(res => {
        this.subject = res;
        this.titleService.title = this.subject.name;


        if (this.reviewDialogInitialState === ReviewDialogInitialState.OpenAndEnableSpoilerFlag){
          Promise.resolve().then(() => {
            this.openDialog(false)
          });
        }
      });
  }

  /*
  Note on autoFocus: It is an accessibility feature.
  The dialog automatically focuses the first focus-able element.
  This can be set as a configurable option if needed
  */
  openDialog(enableSpoilerFlag = false): void {

    // construct review dialog data
    const reviewDialogData: ReviewDialogData = {
      enableSpoilerFlag,
      subject: this.subject,
    };

    const dialogConfig: DialogConfig<ReviewDialogData> = {
      matDialogConfig: {
        data: reviewDialogData,
      },
      sizeConfig: {
        onLtSmScreen: null
      }
    };


    // open the dialog
    const dialogRefObservable = this.reviewDialogService.openDialog(ReviewDialogComponent, dialogConfig);

    dialogRefObservable
      .pipe(
        switchMap(dialogRef => dialogRef.afterClosed()),
        filter(result => result !== undefined && result['rating'] !== undefined),
      )
      .subscribe(result => {
        // this.currentRating = result['rating'];
      });


  }

  ngOnDestroy(): void {
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

  getDeviceWidth() {
    this.layoutService.deviceWidth
      .pipe(
        takeUntil(this.ngUnsubscribe),
      )
      .subscribe(deviceWidth => {
        this.currentDeviceWidth = deviceWidth;
      });
  }


}
