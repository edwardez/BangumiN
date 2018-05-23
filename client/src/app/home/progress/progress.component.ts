import {Component, OnDestroy, OnInit} from '@angular/core';
import {AuthenticationService} from '../../shared/services/auth.service';
import {CollectionWatchingResponseMedium} from '../../shared/models/collection/collection-watching-response-medium';
import {BangumiSubjectService} from '../../shared/services/bangumi/bangumi-subject.service';
import {BangumiUserService} from '../../shared/services/bangumi/bangumi-user.service';
import {forkJoin} from 'rxjs';
import {Subject} from 'rxjs/index';
import {first, map, switchMap, takeUntil, tap} from 'rxjs/operators';

import {SubjectProgress} from '../../shared/models/progress/subject-progress';
import {SubjectType} from '../../shared/enums/subject-type.enum';

@Component({
  selector: 'app-progress',
  templateUrl: './progress.component.html',
  styleUrls: ['./progress.component.scss']
})
export class ProgressComponent implements OnInit, OnDestroy {

  private ngUnsubscribe: Subject<void> = new Subject<void>();
  collectionWatchingArray: CollectionWatchingResponseMedium[];

  constructor(private bangumiUserService: BangumiUserService) {
    this.bangumiUserService.getOngoingCollectionStatusAndProgress()
      .pipe(
        takeUntil(this.ngUnsubscribe)
      )
      .subscribe(response => {
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
