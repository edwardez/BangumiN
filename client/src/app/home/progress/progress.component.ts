import {Component, OnDestroy, OnInit} from '@angular/core';
import {CollectionWatchingResponseMedium} from '../../shared/models/collection/collection-watching-response-medium';
import {BangumiUserService} from '../../shared/services/bangumi/bangumi-user.service';
import {Subject} from 'rxjs';
import {switchMap, take, takeUntil} from 'rxjs/operators';
import {SubjectType} from '../../shared/enums/subject-type.enum';
import {ActivatedRoute, Router} from '@angular/router';
import {TitleService} from '../../shared/services/page/title.service';
import {TranslateService} from '@ngx-translate/core';
import {AuthenticationService} from '../../shared/services/auth.service';

/**
 * Tab index is different from the bangumi type number and it's currently not configurable, add a index here to set index
 */
enum TabIndex {
  all = 0,
  anime = 1,
  real = 2,
  book = 3,
}

@Component({
  selector: 'app-progress',
  templateUrl: './progress.component.html',
  styleUrls: ['./progress.component.scss']
})
export class ProgressComponent implements OnInit, OnDestroy {

  currentIndex = 0;
  collectionWatchingResponse: CollectionWatchingResponseMedium[];

  private ngUnsubscribe: Subject<void> = new Subject<void>();

  constructor(
    private activatedRoute: ActivatedRoute,
    private authenticationService: AuthenticationService,
    private bangumiUserService: BangumiUserService,
    private router: Router,
    private titleService: TitleService,
    private translateService: TranslateService,
  ) {
  }

  get subjectType() {
    return SubjectType;
  }

  get SubjectType() {
    return SubjectType;
  }

  ngOnInit(): void {
    this.bangumiUserService.getOngoingCollectionStatusAndProgress()
      .pipe(
        takeUntil(this.ngUnsubscribe),
      )
      .subscribe(response => {
        this.collectionWatchingResponse = response;
      });

    this.setSelectedIndex();

  }

  ngOnDestroy(): void {
    // unsubscribe, we can also first() in subscription
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
    window.scrollTo(0, 0); // scroll to the top, in some cases user might be confused if next page doesn't start from top
  }

  /**
   * update tab index according to the parameter
   */
  setSelectedIndex() {
    this.activatedRoute.queryParams.subscribe((queryParams: any) => {
      switch (queryParams.type) {
        case SubjectType[SubjectType.all]:
          this.currentIndex = TabIndex.all;
          break;
        case SubjectType[SubjectType.anime]:
          this.currentIndex = TabIndex.anime;
          break;
        case SubjectType[SubjectType.real]:
          this.currentIndex = TabIndex.real;
          break;
        case SubjectType[SubjectType.book]:
          this.currentIndex = TabIndex.book;
          break;
        default:
          this.currentIndex = TabIndex.all;
          break;
      }
    });
    this.setProgressPageTitle(this.currentIndex);
  }

  /**
   * when index is changed, change the query parameter and the page title
   * @param event
   */
  selectedIndexChange(event: number) {
    const urlTree = this.router.parseUrl(this.router.url);
    const urlWithoutParams = urlTree.root.children['primary'].segments.map(it => it.path).join('/');
    this.router.navigate([urlWithoutParams], {queryParams: {type: TabIndex[event]}});
    this.setProgressPageTitle(event);
  }

  /**
   * set the page title, it looks like: `username's xxx ${pageSuffix}`
   * @param index
   */
  setProgressPageTitle(index: number) {
    this.authenticationService.userSubject.pipe(
      take(1),
      switchMap(
        bangumiUser => {
          const nickname = bangumiUser ? bangumiUser.nickname || '' : '';
          return this.translateService.get('progress.tabs.' + TabIndex[index] + '.title', {nickname: nickname});
        }
      ),
    ).subscribe(title => {
      this.titleService.setTitle(title);
    });
  }

}


