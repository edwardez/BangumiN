import {Component, OnDestroy, OnInit} from '@angular/core';
import {BangumiCollectionService} from '../../shared/services/bangumi/bangumi-collection.service';
import {AuthenticationService} from '../../shared/services/auth.service';
import {Subject} from 'rxjs/index';
import {first, map, switchMap, takeUntil, tap} from 'rxjs/operators';
import {CollectionWatchingResponseMedium} from '../../shared/models/collection/collection-watching-response-medium';

@Component({
  selector: 'app-progress',
  templateUrl: './progress.component.html',
  styleUrls: ['./progress.component.scss']
})
export class ProgressComponent implements OnInit, OnDestroy {

  private ngUnsubscribe: Subject<void> = new Subject<void>();
  collectionWatchingArray: CollectionWatchingResponseMedium[];

  constructor(private bangumiCollectionService: BangumiCollectionService,
              private authService: AuthenticationService) {
    this.authService.userSubject
      .pipe(
        takeUntil(this.ngUnsubscribe),
        first(), // we only need user id, which is unlikely to be updated, so only first value(in localStorage) is needed,
        tap( res => {
          console.log(res);
        }),
        switchMap( res => this.bangumiCollectionService.getOngoingCollectionStatusOverview(res['user_id'].toString()))
      )
      .subscribe(res => {
        this.collectionWatchingArray = res;
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
