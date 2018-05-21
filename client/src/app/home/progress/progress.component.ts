import {Component, OnDestroy, OnInit} from '@angular/core';
import {BangumiCollectionService} from '../../shared/services/bangumi/bangumi-collection.service';
import {AuthenticationService} from '../../shared/services/auth.service';
import {forkJoin} from 'rxjs';
import {Subject} from 'rxjs/index';
import {first, map, switchMap, takeUntil, tap} from 'rxjs/operators';
import {CollectionWatchingResponseMedium} from '../../shared/models/collection/collection-watching-response-medium';
import {BangumiSubjectService} from '../../shared/services/bangumi/bangumi-subject.service';
import {BangumiUserService} from '../../shared/services/bangumi/bangumi-user.service';

@Component({
  selector: 'app-progress',
  templateUrl: './progress.component.html',
  styleUrls: ['./progress.component.scss']
})
export class ProgressComponent implements OnInit, OnDestroy {

  private ngUnsubscribe: Subject<void> = new Subject<void>();
  collectionWatchingArray: CollectionWatchingResponseMedium[];

  constructor(private bangumiUserService: BangumiUserService,
              private bangumiSubjectService: BangumiSubjectService,
              private authService: AuthenticationService) {
    this.authService.userSubject
      .pipe(
        takeUntil(this.ngUnsubscribe),
        first(), // we only need user id, which is unlikely to be updated, so only first value(in localStorage) is needed,
        switchMap( res =>
          this.bangumiUserService.getOngoingProgressEpisodeDetail(res['user_id'].toString()).pipe(
            map(episodes => {
              return {'id' : res['user_id'].toString(), 'episodes': episodes};
            })
          )),
        switchMap(res => {
          return forkJoin([this.bangumiUserService.getOngoingCollectionStatusOverview(res.id),
            ...res.episodes.progress.map(episode =>
              this.bangumiSubjectService.getSubjectEpisode(episode.id.toString()).pipe(
                map(episodeInfo => {
                  const episodeIndex = res.episodes.progress.findIndex( ep => ep.id === episodeInfo.id);
                  return {
                    subjectProgress : res.episodes.progressObject[episodeInfo.id],
                    subjectEpisodes: episodeInfo};
                })
              ))]);
        })
      )
      .subscribe(res => {
        // this.collectionWatchingArray = res;
      });
  }

  ngOnDestroy(): void {
    // unsubscribe, we can also first() in subscription
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

  ngOnInit(): void {
  }

}
