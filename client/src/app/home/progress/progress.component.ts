import {ChangeDetectorRef, Component, OnDestroy, OnInit} from '@angular/core';
import {CollectionWatchingResponseMedium} from '../../shared/models/collection/collection-watching-response-medium';
import {BangumiUserService} from '../../shared/services/bangumi/bangumi-user.service';
import {Subject} from 'rxjs/index';
import {takeUntil} from 'rxjs/operators';
import {MatDialog} from '@angular/material';
import {EpisodeDialogComponent} from './episode-dialog/episode-dialog.component';
import {Episode} from '../../shared/models/episode/episode';
import {EpisodeCollectionStatus} from '../../shared/enums/episode-collection-status';
import {SubjectWatchingCollectionMedium} from '../../shared/models/subject/subject-watching-collection-medium';


@Component({
  selector: 'app-progress',
  templateUrl: './progress.component.html',
  styleUrls: ['./progress.component.scss']
})
export class ProgressComponent implements OnInit, OnDestroy {

  private ngUnsubscribe: Subject<void> = new Subject<void>();
  private episodeCollectionStatusUntouched = EpisodeCollectionStatus.untouched;
  collectionWatchingResponse: CollectionWatchingResponseMedium[];

  constructor(private bangumiUserService: BangumiUserService,
              public episodeDialog: MatDialog,
              private changeDetector: ChangeDetectorRef
  ) {

    this.bangumiUserService.getOngoingCollectionStatusAndProgress()
      .pipe(
        takeUntil(this.ngUnsubscribe)
      )
      .subscribe(response => {
        this.collectionWatchingResponse = response;

      });

  }

  ngOnDestroy(): void {
    // unsubscribe, we can also first() in subscription
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

  ngOnInit(): void {
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



}
