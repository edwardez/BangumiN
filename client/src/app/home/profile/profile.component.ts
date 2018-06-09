import {Component, OnDestroy, OnInit} from '@angular/core';
import {SubjectType} from '../../shared/enums/subject-type.enum';
import {BangumiUserService} from '../../shared/services/bangumi/bangumi-user.service';
import {forkJoin, Subject} from 'rxjs/index';
import {filter, switchMap, takeUntil} from 'rxjs/operators';
import {ActivatedRoute} from '@angular/router';
import {UserCollectionResponse} from '../../shared/models/collection/user-collection-response';
import {CollectionStatusId} from '../../shared/enums/collection-status-id';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss']
})
export class ProfileComponent implements OnInit, OnDestroy {

  validSubjectTypeArray: string[] = [];
  userCollectionResponseByType: any;
  private ngUnsubscribe: Subject<void> = new Subject<void>();


  static collectionArrayToObject(collectionArray: any): any {
    return Object.assign({}, ...collectionArray.map(collection => ({[collection.status.id]: collection.collectionUnderCurrentStatus})));

  }



  constructor(private bangumiUserService: BangumiUserService,
              private route: ActivatedRoute) {
    for (const item in SubjectType) {
      if (isNaN(Number(item)) && item !== 'all') {
        this.validSubjectTypeArray.push(item);
      }
    }

    this.route.params
      .pipe(
        filter(params => params['id'] !== undefined),
        switchMap(params => {
          return forkJoin(this.validSubjectTypeArray.map(
            currentSubjectType => {
              return this.bangumiUserService.getUserCollectionByType(params['id'], currentSubjectType)
                .pipe(
                  takeUntil(this.ngUnsubscribe)
                );
            }
          ));
        }),
      )
      .subscribe(userCollectionResponseArray => {
        this.userCollectionResponseByType = Object.assign({}, ...userCollectionResponseArray.map(userCollectionResponse => ({
          [userCollectionResponse.type]:
            ProfileComponent.collectionArrayToObject(userCollectionResponse.collectionArray)
        })));
      });


  }


  ngOnDestroy(): void {
    // unsubscribe, we can also first() in subscription
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

  ngOnInit() {
  }

  undefinedOrEmpty(value: Object, args?: any): boolean {
    return value === undefined ||
      (Object.keys(value).length === 0);
  }


  get subjectType() {
    return SubjectType;
  }

  get collectionStatus() {
    return CollectionStatusId;
  }

  onStatsSelected(tab) {
    if(tab.textLabel === 'Stats') {
      // fetch user stats
      console.log("stats!!!!!");
    }
  }


}
