import {Component, OnDestroy, OnInit} from '@angular/core';
import {ActivatedRoute} from '@angular/router';
import {filter, switchMap, takeUntil} from 'rxjs/operators';
import {Subject} from 'rxjs';
import {BanguminSpoilerService} from '../../../../../shared/services/bangumin/bangumin-spoiler.service';
import {SpoilerExisted} from '../../../../../shared/models/spoiler/spoiler-existed';
import {BangumiUser} from '../../../../../shared/models/BangumiUser';
import {SubjectBase} from '../../../../../shared/models/subject/subject-base';
import {BangumiUserService} from '../../../../../shared/services/bangumi/bangumi-user.service';

@Component({
  selector: 'app-spoiler-single-wrapper',
  templateUrl: './spoiler-single-wrapper.component.html',
  styleUrls: ['./spoiler-single-wrapper.component.scss']
})
export class SpoilerSingleWrapperComponent implements OnInit, OnDestroy {

  spoilerContent: SpoilerExisted;
  bangumiUser: BangumiUser;
  relatedSubjects: SubjectBase[];
  private ngUnsubscribe: Subject<void> = new Subject<void>();

  constructor(private activatedRoute: ActivatedRoute,
              private bangumiUserService: BangumiUserService,
              private banguminSpoilerService: BanguminSpoilerService,) {
  }

  ngOnInit() {
    this.activatedRoute
      .params
      .pipe(
        takeUntil(this.ngUnsubscribe),
        filter(params => params['userId'] && params['spoilerId']),
        switchMap(params => {
            const userId = params['userId'];
            const spoilerId = params['spoilerId'];
          return this.banguminSpoilerService.getSingleAlienSpoilerBasicInfo(userId, spoilerId);
          },
        ),
        switchMap((spoilerExisted) => {
          this.spoilerContent = spoilerExisted;
          return this.banguminSpoilerService.getSpoilerRelatedSubjectInfo(spoilerExisted.userId, spoilerExisted.relatedSubjects);
        }))
      .subscribe(spoilerExisted => {
        this.bangumiUser = spoilerExisted[0] as BangumiUser;
        this.relatedSubjects = spoilerExisted[1] as SubjectBase[];
      });
  }

  ngOnDestroy(): void {
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

}
