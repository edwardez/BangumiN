import {Component, Input, OnDestroy, OnInit} from '@angular/core';
import {SubjectWatchingCollectionMedium} from '../../../shared/models/subject/subject-watching-collection-medium';
import {EpisodeDialogComponent} from '../episode-dialog/episode-dialog.component';
import {CollectionWatchingResponseMedium} from '../../../shared/models/collection/collection-watching-response-medium';
import {Episode} from '../../../shared/models/episode/episode';
import {EpisodeCollectionStatus} from '../../../shared/enums/episode-collection-status';
import {MatDialog} from '@angular/material';
import {SubjectType} from '../../../shared/enums/subject-type.enum';
import {FormBuilder, FormGroup} from '@angular/forms';
import {BangumiCollectionService} from '../../../shared/services/bangumi/bangumi-collection.service';
import {ReviewDialogData} from '../../../shared/models/review/reviewDialogData';
import {DialogConfig, ResponsiveDialogService} from '../../../shared/services/dialog/responsive-dialog.service';
import {LayoutService} from '../../../shared/services/layout/layout.service';
import {environment} from '../../../../environments/environment';
import {Subject} from 'rxjs/index';
import {takeUntil} from 'rxjs/operators';
import {ReviewDialogComponent} from '../../../subject/review-dialog/review-dialog.component';

@Component({
  selector: 'app-progess-by-subject',
  templateUrl: './progress-by-subject.component.html',
  styleUrls: ['./progress-by-subject.component.scss']
})
export class ProgressBySubjectComponent implements OnInit, OnDestroy {

  firstNElementCount: number;
  bookProgressForm: FormGroup;
  private ngUnsubscribe: Subject<void> = new Subject<void>();

  @Input()
  collection: CollectionWatchingResponseMedium;

  constructor(public episodeDialog: MatDialog,
              private formBuilder: FormBuilder,
              private bangumiCollectionService: BangumiCollectionService,
              private reviewDialogService: ResponsiveDialogService,
              private layoutService: LayoutService) {
  }

  ngOnInit() {
    if (this.collection.subject.type === SubjectType.book) {
      this.createBookProgressForm();
    }

    this.calculateProgressPageMaxEpisodeCount();
  }

  ngOnDestroy(): void {
    // unsubscribe, we can also first() in subscription
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

  createBookProgressForm() {
    this.bookProgressForm = this.formBuilder.group(
      {
        'completedVolumeCount': this.collection.completedVolumeCount,
        'completedEpisodeCount': this.collection.completedEpisodeCount,
      }
    );
  }

  /**
   * calculate maximum umber of episode chips that should be displayed on the page
   */
  calculateProgressPageMaxEpisodeCount() {
    this.layoutService.deviceWidth
      .pipe(
        takeUntil(this.ngUnsubscribe)
      )
      .subscribe(deviceWidth => {
        if (LayoutService.xs(deviceWidth)) {
          this.firstNElementCount = environment.progressPageMaxEpisodeCountMobile;
        } else {
          this.firstNElementCount = environment.progressPageMaxEpisodeCountDesktop;
        }
      });
  }

  submitBookProgress() {
    const bookProgressModel = this.bookProgressForm.value;
    this.bangumiCollectionService.upsertEpisodeStatusBatch(
      this.collection, bookProgressModel.completedEpisodeCount,
      bookProgressModel.completedVolumeCount).subscribe(res => {
    });
  }


  openEpisodeDialog(subject: SubjectWatchingCollectionMedium, episode: Episode): void {
    const dialogRef = this.episodeDialog.open(EpisodeDialogComponent, {
      data: {'subject': subject, 'episode': episode}
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result && result.response.code === 200) {
        episode.userCollectionStatus = result.collectionStatus;
      }
    });
  }

  calculateCollectionProgress(collectionWatchingResponseMedium: CollectionWatchingResponseMedium) {
    if (collectionWatchingResponseMedium.subject.totalEpisodesCount <= 0) {
      return 0;
    } else {
      return collectionWatchingResponseMedium.completedEpisodeCount / collectionWatchingResponseMedium.subject.totalEpisodesCount * 100;
    }
  }

  calculateChipColorByEpisodeStatus(userCollectionStatus: number | null): string {
    switch (userCollectionStatus) {
      case EpisodeCollectionStatus.watched:
        return 'primary';
      case EpisodeCollectionStatus.drop:
        return 'warn';
      default:
        return 'primary';
    }
  }

  /*
  Note on autoFocus: It is an accessibility feature.
  The dialog automatically focuses the first focus-able element.
  This can be set as a configurable option if needed
  */
  openReviewDialog(): void {
    this.bangumiCollectionService.getSubjectCollectionStatus(this.collection.id.toString()).subscribe(res => {

      // construct review dialog data
      const reviewDialogData: ReviewDialogData = {
        subjectId: this.collection.id,
        rating: res.rating,
        tags: res.tags,
        statusType: res.status.type,
        comment: res.comment,
        privacy: res.privacy,
        type: this.collection.subject.type,
        name: this.collection.subject.name
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
      this.reviewDialogService.openDialog(ReviewDialogComponent, dialogConfig).subscribe(dialogRef => {
      });


    });


  }


  get SubjectType() {
    return SubjectType;
  }

  get EpisodeCollectionStatus() {
    return EpisodeCollectionStatus;
  }

}
