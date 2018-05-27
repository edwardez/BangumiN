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
import {SubjectType} from '../../shared/enums/subject-type.enum';


@Component({
  selector: 'app-progress',
  templateUrl: './progress.component.html',
  styleUrls: ['./progress.component.scss']
})
export class ProgressComponent implements OnInit, OnDestroy {

  private ngUnsubscribe: Subject<void> = new Subject<void>();

  collectionWatchingResponse: CollectionWatchingResponseMedium[];

  constructor(private bangumiUserService: BangumiUserService,
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

  filterBySubjectType(collectionWatchingResponse: CollectionWatchingResponseMedium[],
                      subjectType: SubjectType): CollectionWatchingResponseMedium[] {
    const filteredCollectionWatchingResponse: CollectionWatchingResponseMedium[] = [];

    for (const collection of collectionWatchingResponse) {
      if (collection.subject.type === subjectType) {
        filteredCollectionWatchingResponse.push(collection);
      }
    }

    return filteredCollectionWatchingResponse;

  }

  get subjectType() {
    return SubjectType;
  }


}
