import {Component, OnDestroy, OnInit} from '@angular/core';
import {MatDialog} from '@angular/material';
import {SpoilerCreationComponent} from '../spoiler-creation/spoiler-creation.component';
import {ResponsiveDialogService} from '../../../../shared/services/dialog/responsive-dialog.service';
import {BanguminSpoilerService} from '../../../../shared/services/bangumin/bangumin-spoiler.service';
import {ActivatedRoute} from '@angular/router';
import {concatMap, filter, map, switchMap, take, takeUntil} from 'rxjs/operators';
import {forkJoin, of, Subject} from 'rxjs';
import {BangumiUser} from '../../../../shared/models/BangumiUser';
import {SpoilerExisted} from '../../../../shared/models/spoiler/spoiler-existed';
import {BangumiUserService} from '../../../../shared/services/bangumi/bangumi-user.service';
import {SpoilerCreationGuideComponent} from '../spoiler-creation-guide/spoiler-creation-guide.component';
import {TitleService} from '../../../../shared/services/page/title.service';

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
  visitedSpoilers: Set<string> = new Set();
  SPOILERS_PER_QUERY = 10;
  private ngUnsubscribe: Subject<void> = new Subject<void>();

  constructor(private activatedRoute: ActivatedRoute,
              private dialog: MatDialog,
              private bangumiUserService: BangumiUserService,
              private banguminSpoilerService: BanguminSpoilerService,
              private responsiveDialogService: ResponsiveDialogService,
              private titleService: TitleService,
  ) {
  }


  ngOnInit() {
    this.activatedRoute
      .params
      .pipe(
        filter(params => params['userId']),
        take(1),
      )
      .subscribe(params => {
        this.bangumiUserService.getUserInfoFromHttp(params['userId'])
          .subscribe(bangumiUser => {
            this.bangumiUser = bangumiUser;
            this.titleService.setTitleByTranslationLabel('posts.bangumin.spoilerBox.headline', {name: bangumiUser.nickname});
          });
        this.getSpoilersInfo(params['userId']);
      });

    this.listenToSpoilerDeletionSubject();
  }

  /**
   * Listen to the spoiler deletion event and update spoiler array accordingly
   */
  listenToSpoilerDeletionSubject() {
    this.banguminSpoilerService.spoilerDeletionSubject.pipe(
      takeUntil(this.ngUnsubscribe)
    ).subscribe(spoilerDeletionResult => {
      if (this.userSpoilers && spoilerDeletionResult.spoilerId && spoilerDeletionResult.isSuccessful) {
        for (let i = 0; i < this.userSpoilers.length; i++) {
          if (this.userSpoilers[i].spoilerId === spoilerDeletionResult.spoilerId) {
            this.userSpoilers.splice(i, 1);
            this.visitedSpoilers.delete(spoilerDeletionResult.spoilerId);
            // if total number of spoilers are less than half of spoilers per query and we haven't reached end of content, trying to load
            // more spoilers
            if (this.userSpoilers.length <= this.SPOILERS_PER_QUERY / 2 && !this.endOfContent) {
              this.getOlderSpoilers();
            }
            // spoiler id is unique and only one spoiler can currently be deleted, break the loop after the first deletion event is handled
            break;
          }
        }
      }
    });
  }

  openDialog(): void {
    this.responsiveDialogService.openDialog(SpoilerCreationComponent, {
      sizeConfig: {
        onLtSmScreen: {
          width: '50vw',
          maxWidth: '50vw',
          maxHeight: '80vh',
        }
      }
    }).pipe(
      concatMap(dialogRef => dialogRef.afterClosed()),
      take(1),
    )
      .subscribe(spoilerCreationResult => {
        if (spoilerCreationResult && spoilerCreationResult.spoilerId && spoilerCreationResult.isSuccessful) {
          const createdAtStart = this.userSpoilers.length >= 1 ? +this.userSpoilers[0].createdAt + 1 : undefined;
          this.getSpoilersInfo(this.bangumiUser.id, false, createdAtStart,
            undefined);
        }

      });
  }

  openSpoilerCreationGuideDialog(): void {
    this.responsiveDialogService.openDialog(SpoilerCreationGuideComponent, {
      sizeConfig: {
        onLtSmScreen: {}
      }
    })
      .pipe(
        take(1),
      )
      .subscribe();
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
    this.getOlderSpoilers();
  }

  getOlderSpoilers() {
    if (this.bangumiUser) {
      const createdAtEnd = this.userSpoilers.length >= 1 ? +this.userSpoilers[this.userSpoilers.length - 1].createdAt : undefined;
      this.getSpoilersInfo(this.bangumiUser.id, true, undefined, createdAtEnd);
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
    this.banguminSpoilerService.getSpoilersBasicInfo(userId, createdAtStart, createdAtEnd, this.SPOILERS_PER_QUERY).pipe(
      map(
        userSpoilers => {
          // in rare cases if duplications are accidentally added, filter them out
          userSpoilers['spoilers'] = userSpoilers['spoilers'].filter((spoiler: SpoilerExisted) => {
            const isSpoilerAlreadyVisited = this.visitedSpoilers.has(spoiler.spoilerId);
            this.visitedSpoilers.add(spoiler.spoilerId);
            return !isSpoilerAlreadyVisited;
          });
          return userSpoilers;
        }
      ),
      switchMap(userSpoilers => {
        newUserSpoilers = userSpoilers['spoilers'];
        this.setEndOfContentFlag(userSpoilers['lastKey'], createdAtStart);
        if (newUserSpoilers.length !== 0) {
          // this response contains data, but it's the end of response, set relevant flags
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
          // only if we're querying until the end of spoilers so add a guard `createdAtStart === 0`
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

  /**
   * CHeck if all available soilers have been added, if so, disable the loader
   * @param lastKey last key of the spoiler(see dynamodb for lasyKey definition)
   * @param createdAtStart the createdAtStart paramter in querying
   * @param oldestTimeStamp In Theory, the oldest timestamp of spoilers(users can't post a spoiler before this time)
   */
  setEndOfContentFlag(lastKey: Object, createdAtStart: number, oldestTimeStamp = 0): void {
    if (!lastKey && createdAtStart === oldestTimeStamp) {
      this.infiniteScrollDisabled = true;
      this.endOfContent = true;
    }

  }


}
