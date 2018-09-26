import {Component, OnDestroy, OnInit} from '@angular/core';
import {filter, switchMap, takeUntil} from 'rxjs/operators';
import {ActivatedRoute} from '@angular/router';
import {BangumiSubjectService} from '../shared/services/bangumi/bangumi-subject.service';
import {BangumiCollectionService} from '../shared/services/bangumi/bangumi-collection.service';
import {TitleService} from '../shared/services/page/title.service';
import {ResponsiveDialogService} from '../shared/services/dialog/responsive-dialog.service';
import {LayoutService} from '../shared/services/layout/layout.service';
import {SnackBarService} from '../shared/services/snackBar/snack-bar.service';
import {Subject} from 'rxjs';
import {SubjectType} from '../shared/enums/subject-type.enum';
import {DeviceWidth} from '../shared/enums/device-width.enum';
import {SubjectLarge} from '../shared/models/subject/subject-large';

@Component({
  selector: 'app-subject',
  templateUrl: './subject.component.html',
  styleUrls: ['./subject.component.scss']
})
export class SubjectComponent implements OnInit, OnDestroy {

  currentDeviceWidth: DeviceWidth;
  subject: SubjectLarge;
  currentRating = 0;

  private ngUnsubscribe: Subject<void> = new Subject<void>();

  constructor(private activatedRoute: ActivatedRoute,
              private bangumiSubjectService: BangumiSubjectService,
              private bangumiCollectionService: BangumiCollectionService,
              private titleService: TitleService,
              private reviewDialogService: ResponsiveDialogService,
              private layoutService: LayoutService,
              private snackBarService: SnackBarService) {
    this.activatedRoute
      .params
      .pipe(
        filter(params => !!params['subjectId']),
        switchMap(params => {
          return this.bangumiSubjectService.getSubject(params['subjectId'], 'large');
          },
        ),
        takeUntil(this.ngUnsubscribe),
      )
      .subscribe(res => {
        this.subject = res;
        this.titleService.title = this.subject.name;
      });
  }


  get SubjectType() {
    return SubjectType;
  }

  get LayoutService() {
    return LayoutService;
  }

  ngOnInit() {
    this.getDeviceWidth();
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
