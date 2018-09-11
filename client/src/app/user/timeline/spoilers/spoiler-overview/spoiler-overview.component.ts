import {Component, OnDestroy, OnInit} from '@angular/core';
import {MatDialog} from '@angular/material';
import {SpoilerCreationComponent} from '../spoiler-creation/spoiler-creation.component';
import {ResponsiveDialogService} from '../../../../shared/services/dialog/responsive-dialog.service';
import {BanguminSpoilerService} from '../../../../shared/services/bangumin/bangumin-spoiler.service';
import {ActivatedRoute} from '@angular/router';
import {concatMap, filter, switchMap, take} from 'rxjs/operators';
import {forkJoin, of, Subject} from 'rxjs';
import {BangumiUser} from '../../../../shared/models/BangumiUser';
import {SpoilerExisted} from '../../../../shared/models/spoiler/spoiler-existed';
import {BangumiUserService} from '../../../../shared/services/bangumi/bangumi-user.service';

@Component({
  selector: 'app-spoiler-overview',
  templateUrl: './spoiler-overview.component.html',
  styleUrls: ['./spoiler-overview.component.scss']
})
export class SpoilerOverviewComponent implements OnInit, OnDestroy {

  endOfContent = false;
  infiniteScrollDisabled = false;
  bangumiUser: BangumiUser;
  userSpoilers: SpoilerExisted[] = [];
  private ngUnsubscribe: Subject<void> = new Subject<void>();

  constructor(private activatedRoute: ActivatedRoute,
              private dialog: MatDialog,
              private bangumiUserService: BangumiUserService,
              private banguminSpoilerService: BanguminSpoilerService,
              private spoilerCreationDialogService: ResponsiveDialogService,
  ) {
  }


  ngOnInit() {
    this.activatedRoute
      .parent.parent
      .params
      .pipe(
        filter(params => params['userId']),
      )
      .subscribe(params => {
        this.bangumiUserService.getUserInfoFromHttp(params['userId'])
          .pipe(take(1))
          .subscribe(bangumiUser => {
            this.bangumiUser = bangumiUser;
          });
        this.getSpoilersInfo(params['userId']);
      });
  }

  openDialog(): void {
    this.spoilerCreationDialogService.openDialog(SpoilerCreationComponent, {
      sizeConfig: {
        onLtSmScreen: {
          width: '50vw',
          maxWidth: '50vw',
          maxHeight: '80vh',
        }
      }
    }).pipe(
      concatMap(dialogRef => dialogRef.afterClosed())
    )
      .subscribe(result => {
        this.getSpoilersInfo(this.bangumiUser.id, false, +this.userSpoilers[0].createdAt + 1,
          +new Date());
      });
  }

  ngOnDestroy(): void {
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

  /**
   * On scroll down, call api to get more spoilers
   * TODO: refactor the code using a pure rxjs way(i.e. get user from observable, use concatMap to control sequential requests)
   */
  onScrollDown() {

    if (this.bangumiUser) {
      this.getSpoilersInfo(this.bangumiUser.id, true, undefined, +this.userSpoilers[this.userSpoilers.length - 1].createdAt);
    }

  }

  /**
   * get spoilers and update the spoiler array
   * @param userId user id
   * @param appendNewSpoilers If set to true, new spoilers will be appended to the end of the array, other wise it'll be prepended to the
   *     top
   * @param createdAtStart get spoilers after this time
   * @param createdAtEnd get spoilers before this time
   */
  getSpoilersInfo(userId: string | number, appendNewSpoilers = true, createdAtStart = 0, createdAtEnd = Date.now()) {

    let newUserSpoilers: SpoilerExisted[] = [];
    this.banguminSpoilerService.getSpoilersBasicInfo(userId, createdAtStart, createdAtEnd).pipe(
      switchMap(userSpoilers => {

        newUserSpoilers = userSpoilers['spoilers'];
        if (newUserSpoilers.length !== 0) {
          // this response contains data, but it's the end of response, set relevant flags
          if (!userSpoilers['lastKey']) {
            this.setEndOfContentFlag();
          }
          // TODO: optimize requests(might contain duplicates)
          if (appendNewSpoilers) {
            this.userSpoilers.push(...newUserSpoilers);
          } else {
            this.userSpoilers.unshift(...newUserSpoilers);
          }
          return forkJoin(
            newUserSpoilers.map(userSpoiler => this.banguminSpoilerService.getSpoilerRelatedSubjectInfo(userSpoiler.relatedSubjects)));
        } else {
          // this response contains empty response,  set relevant flags and return null to indicate "don't proceed"
          this.setEndOfContentFlag();
          return of(null);
        }

        }
      )).subscribe(res => {
      if (res) {
        newUserSpoilers.forEach(userSpoiler => {
          userSpoiler.relatedSubjectsBaseDetails = res[newUserSpoilers.indexOf(userSpoiler)];
        });
      }

    });
  }

  setEndOfContentFlag(): void {
    this.infiniteScrollDisabled = true;
    this.endOfContent = true;
  }


}
