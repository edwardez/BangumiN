import {Component, Input, OnInit} from '@angular/core';
import {EpisodeCollectionStatus} from '../../../shared/enums/episode-collection-status';
import {SubjectWatchingCollectionMedium} from '../../../shared/models/subject/subject-watching-collection-medium';
import {Episode} from '../../../shared/models/episode/episode';
import {CollectionWatchingResponseMedium} from '../../../shared/models/collection/collection-watching-response-medium';
import {EpisodeDialogComponent} from '../episode-dialog/episode-dialog.component';
import {MatDialog} from '@angular/material';

@Component({
  selector: 'app-progress-by-type',
  templateUrl: './progress-by-type.component.html',
  styleUrls: ['./progress-by-type.component.scss']
})
export class ProgressByTypeComponent implements OnInit {

  @Input()
  collectionWatchingResponse: CollectionWatchingResponseMedium[];

  private episodeCollectionStatusUntouched = EpisodeCollectionStatus.untouched;

  constructor( public episodeDialog: MatDialog) { }

  ngOnInit() {
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
