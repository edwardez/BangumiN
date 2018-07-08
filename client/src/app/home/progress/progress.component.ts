import {Component, OnDestroy, OnInit} from '@angular/core';
import {CollectionWatchingResponseMedium} from '../../shared/models/collection/collection-watching-response-medium';
import {BangumiUserService} from '../../shared/services/bangumi/bangumi-user.service';
import {Subject} from 'rxjs/index';
import {takeUntil} from 'rxjs/operators';
import {SubjectType} from '../../shared/enums/subject-type.enum';


@Component({
  selector: 'app-progress',
  templateUrl: './progress.component.html',
  styleUrls: ['./progress.component.scss']
})
export class ProgressComponent implements OnInit, OnDestroy {

  private ngUnsubscribe: Subject<void> = new Subject<void>();

  collectionWatchingResponse: CollectionWatchingResponseMedium[];

  constructor(private bangumiUserService: BangumiUserService,) {
  }

  ngOnDestroy(): void {
    // unsubscribe, we can also first() in subscription
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
    window.scrollTo(0, 0); // scroll to the top, in some cases user might be confused if next page doesn't start from top
  }

  ngOnInit(): void {
    this.bangumiUserService.getOngoingCollectionStatusAndProgress()
      .pipe(
        takeUntil(this.ngUnsubscribe),
      )
      .subscribe(response => {
        this.collectionWatchingResponse = response;

      });
  }


  get subjectType() {
    return SubjectType;
  }


}
