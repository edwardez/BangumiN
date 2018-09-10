import {Component, OnDestroy, OnInit} from '@angular/core';
import {MatDialog} from '@angular/material';
import {SpoilerCreationComponent} from '../spoiler-creation/spoiler-creation.component';
import {ResponsiveDialogService} from '../../../../shared/services/dialog/responsive-dialog.service';
import {BanguminSpoilerService} from '../../../../shared/services/bangumin/bangumin-spoiler.service';
import {ActivatedRoute} from '@angular/router';
import {filter, switchMap, take, takeUntil, tap} from 'rxjs/operators';
import {forkJoin, Subject} from 'rxjs';
import {BangumiUser} from '../../../../shared/models/BangumiUser';
import {SpoilerExisted} from '../../../../shared/models/spoiler/spoiler-existed';
import {BangumiUserService} from '../../../../shared/services/bangumi/bangumi-user.service';

@Component({
  selector: 'app-spoiler-overview',
  templateUrl: './spoiler-overview.component.html',
  styleUrls: ['./spoiler-overview.component.scss']
})
export class SpoilerOverviewComponent implements OnInit, OnDestroy {

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
        takeUntil(this.ngUnsubscribe),
        filter(params => params['userId']),
        tap(params => {
            this.bangumiUserService.getUserInfoFromHttp(params['userId'])
              .pipe(take(1))
              .subscribe(bangumiUser => {
                this.bangumiUser = bangumiUser;
              });
          }
        ),
        switchMap(params => {
            return this.banguminSpoilerService.getSpoilersBasicInfo(params['userId']);
          },
        ),
        switchMap(userSpoilers => {
          this.userSpoilers = userSpoilers;
          // TODO: optimize requests(might contain duplicates)
          return forkJoin(
            this.userSpoilers.map(userSpoiler => this.banguminSpoilerService.getSpoilerRelatedSubjectInfo(userSpoiler.relatedSubjects)));
        })
      )
      .subscribe(res => {
        this.userSpoilers.forEach(userSpoiler => {
          userSpoiler.relatedSubjectsBaseDetails = res[this.userSpoilers.indexOf(userSpoiler)];
        });
      });
  }

  openDialog(): void {
    const dialogRef = this.spoilerCreationDialogService.openDialog(SpoilerCreationComponent, {
      sizeConfig: {
        onLtSmScreen: {
          width: '50vw',
          maxWidth: '50vw',
          maxHeight: '80vh',
        }
      }
    }).subscribe();
  }

  ngOnDestroy(): void {
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

  onScrollDown() {
    if (this.bangumiUser) {
      this.getSpoilersInfo(this.bangumiUser.id, undefined, +this.userSpoilers[this.userSpoilers.length - 1].createdAt);
    }

  }

  getSpoilersInfo(userId: string | number, createdAtStart = 0, createdAtEnd = Date.now()) {
    let newUserSpoilers: SpoilerExisted[] = [];
    this.banguminSpoilerService.getSpoilersBasicInfo(userId, createdAtStart, createdAtEnd).pipe(
      switchMap(userSpoilers => {
          newUserSpoilers = userSpoilers;
          this.userSpoilers.push(...newUserSpoilers);
          // TODO: optimize requests(might contain duplicates)
          return forkJoin(
            newUserSpoilers.map(userSpoiler => this.banguminSpoilerService.getSpoilerRelatedSubjectInfo(userSpoiler.relatedSubjects)));
        }
      )).subscribe(res => {
      newUserSpoilers.forEach(userSpoiler => {
        userSpoiler.relatedSubjectsBaseDetails = res[newUserSpoilers.indexOf(userSpoiler)];
      });
    });
  }


}
