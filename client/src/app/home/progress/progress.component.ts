import {Component, OnDestroy, OnInit} from '@angular/core';
import {CollectionWatchingResponseMedium} from '../../shared/models/collection/collection-watching-response-medium';
import {BangumiUserService} from '../../shared/services/bangumi/bangumi-user.service';
import {Subject} from 'rxjs/index';
import {takeUntil} from 'rxjs/operators';
import {MatDialog} from '@angular/material';
import {EpisodeDialogComponent} from './episode-dialog/episode-dialog.component';
import {Episode} from '../../shared/models/episode/episode';
import {EpisodeCollectionStatus} from '../../shared/enums/episode-collection-status';


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
              public episodeDialog: MatDialog) {
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

  calculateCollectionProgress(collectionWatchingResponseMedium: CollectionWatchingResponseMedium) {
    if (collectionWatchingResponseMedium.subject.totalEpisodesCount <= 0) {
      return 0;
    } else {
      return collectionWatchingResponseMedium.completedEpisodeCount / collectionWatchingResponseMedium.subject.totalEpisodesCount * 100;
    }
  }

  calculateChipColorByEpisodeStatus(userCollectionStatus: number|null): string {
     switch (userCollectionStatus) {
       case 2:
         return 'primary';
       case 3:
         return 'warn';
       default:
         return 'primary';
     }
  }

  openEpisodeDialog(episode: Episode): void {
    const dialogRef = this.episodeDialog.open(EpisodeDialogComponent, {
      data: episode
    });

    dialogRef.afterClosed().subscribe(result => {
    });
  }

}
