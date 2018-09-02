import {Location} from '@angular/common';
import {Component, OnDestroy, OnInit} from '@angular/core';
import {ActivatedRoute} from '@angular/router';
import {forkJoin, Subject} from 'rxjs';
import {BangumiUserService} from '../../../shared/services/bangumi/bangumi-user.service';
import {SubjectType} from '../../../shared/enums/subject-type.enum';
import {filter, switchMap, takeUntil} from 'rxjs/operators';
import {CollectionStatusId} from '../../../shared/enums/collection-status-id';

@Component({
  selector: 'app-collection-home',
  templateUrl: './collection-home.component.html',
  styleUrls: ['./collection-home.component.scss']
})
export class CollectionHomeComponent implements OnInit, OnDestroy {

  validSubjectTypeArray: string[] = [];
  userCollectionResponseByType: any;

  private ngUnsubscribe: Subject<void> = new Subject<void>();

  constructor(private activatedRoute: ActivatedRoute,
              private bangumiUserService: BangumiUserService,
              private location: Location,
  ) {
  }

  get subjectType() {
    return SubjectType;
  }

  get collectionStatus() {
    return CollectionStatusId;
  }

  static collectionArrayToObject(collectionArray: any): any {
    return Object.assign({}, ...collectionArray.map(collection => ({[collection.status.id]: collection.collectionUnderCurrentStatus})));

  }

  ngOnDestroy(): void {
    // unsubscribe, we can also first() in subscription
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

  ngOnInit() {
    for (const item in SubjectType) {
      if (isNaN(Number(item)) && item !== 'all') {
        this.validSubjectTypeArray.push(item);
      }
    }

    this.activatedRoute.parent.params
      .pipe(
        filter(params => params && params['userId']),
        switchMap(params => {
          return forkJoin(this.validSubjectTypeArray.map(
            currentSubjectType => {
              return this.bangumiUserService.getUserCollectionByType(params['userId'], currentSubjectType)
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
            CollectionHomeComponent.collectionArrayToObject(userCollectionResponse.collectionArray)
        })));
      });
  }

  undefinedOrEmpty(value: Object, args?: any): boolean {
    return value === undefined ||
      (Object.keys(value).length === 0);
  }

}
