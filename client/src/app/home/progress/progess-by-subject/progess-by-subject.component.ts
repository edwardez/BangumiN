import {Component, Input, OnInit} from '@angular/core';
import {SubjectWatchingCollectionMedium} from '../../../shared/models/subject/subject-watching-collection-medium';
import {EpisodeDialogComponent} from '../episode-dialog/episode-dialog.component';
import {CollectionWatchingResponseMedium} from '../../../shared/models/collection/collection-watching-response-medium';
import {Episode} from '../../../shared/models/episode/episode';
import {EpisodeCollectionStatus} from '../../../shared/enums/episode-collection-status';
import {MatDialog} from '@angular/material';
import {SubjectType} from '../../../shared/enums/subject-type.enum';
import {FormBuilder, FormGroup} from '@angular/forms';
import {BangumiCollectionService} from '../../../shared/services/bangumi/bangumi-collection.service';
import {ReviewDialogComponent} from '../../../subject/review-dialog/review-dialog.component';
import {filter} from 'rxjs/operators';

@Component({
  selector: 'app-progess-by-subject',
  templateUrl: './progess-by-subject.component.html',
  styleUrls: ['./progess-by-subject.component.scss']
})
export class ProgessBySubjectComponent implements OnInit {

  private bookProgressForm: FormGroup;

  @Input()
  collection: CollectionWatchingResponseMedium;

  constructor(public episodeDialog: MatDialog,
              public reviewDialog: MatDialog,
              private formBuilder: FormBuilder,
              private bangumiCollectionService: BangumiCollectionService) {
  }

  ngOnInit() {
    if (this.collection.subject.type === SubjectType.book) {
      this.createBookProgressForm();
    }
  }

  createBookProgressForm() {
    this.bookProgressForm = this.formBuilder.group(
      {
        'completedVolumeCount': this.collection.completedVolumeCount,
        'completedEpisodeCount': this.collection.completedEpisodeCount,
      }
    );
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
  openDialog(): void {
    this.bangumiCollectionService.getSubjectCollectionStatus(this.collection.id.toString()).subscribe(res => {
      const dialogRef = this.reviewDialog.open(ReviewDialogComponent, {
        data: {
          subjectId: this.collection.id,
          rating: res.rating,
          tags: res.tags,
          statusType: res.status.type,
          comment: res.comment,
          privacy: res.privacy,
          type: this.collection.subject.type
        },
        autoFocus: false
      });

      dialogRef.afterClosed()
        .pipe(
          filter(result => result !== undefined && result.rating !== undefined)
        )
        .subscribe(
          result => {

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
