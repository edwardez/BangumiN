import {Component, OnDestroy, OnInit} from '@angular/core';
import {filter, switchMap, takeUntil} from 'rxjs/operators';
import {ActivatedRoute} from '@angular/router';
import {BangumiSubjectService} from '../shared/services/bangumi/bangumi-subject.service';
import {BangumiCollectionService} from '../shared/services/bangumi/bangumi-collection.service';
import {TitleService} from '../shared/services/page/title.service';
import {ResponsiveDialogService} from '../shared/services/dialog/responsive-dialog.service';
import {LayoutService} from '../shared/services/layout/layout.service';
import {SnackBarService} from '../shared/services/snackBar/snack-bar.service';
import {forkJoin, Subject} from 'rxjs';
import {SubjectType} from '../shared/enums/subject-type.enum';
import {DeviceWidth} from '../shared/enums/device-width.enum';
import {SubjectLarge} from '../shared/models/subject/subject-large';
import {CollectionResponse} from '../shared/models/collection/collection-response';

@Component({
  selector: 'app-subject',
  templateUrl: './subject.component.html',
  styleUrls: ['./subject.component.scss']
})
export class SubjectComponent implements OnInit, OnDestroy {

  currentDeviceWidth: DeviceWidth;
  subject: SubjectLarge;
  currentRating = 0;
  collectionResponse: CollectionResponse;

  private ngUnsubscribe: Subject<void> = new Subject<void>();

  constructor(private route: ActivatedRoute,
              private bangumiSubjectService: BangumiSubjectService,
              private bangumiCollectionService: BangumiCollectionService,
              private titleService: TitleService,
              private reviewDialogService: ResponsiveDialogService,
              private layoutService: LayoutService,
              private snackBarService: SnackBarService) {
  }


  get SubjectType() {
    return SubjectType;
  }

  get LayoutService() {
    return LayoutService;
  }

  ngOnInit() {
    this.getDeviceWidth();

    this.route
      .params
      .pipe(
        takeUntil(this.ngUnsubscribe),
        filter(params => !!params['id']),
        switchMap(params => {
            return forkJoin(
              this.bangumiSubjectService.getSubject(params['id'], 'large'),
              this.bangumiCollectionService.getSubjectCollectionStatus(params['id']),
            );
          },
        ))
      .subscribe(res => {
        this.subject = res[0];
        this.titleService.title = this.subject.name;
        this.collectionResponse = res[1];
        this.currentRating = this.collectionResponse.rating;
      });
  }


  getDeviceWidth() {
    this.layoutService.deviceWidth
      .pipe(
        takeUntil(this.ngUnsubscribe),
      )
      .subscribe(deviceWidth => {
        this.currentDeviceWidth = deviceWidth;
      });
  }

  ngOnDestroy(): void {
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

}
