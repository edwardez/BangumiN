import {Injectable} from '@angular/core';
import {ReviewDialogData} from '../../models/review/reviewDialogData';
import {MatDialog} from '@angular/material';
import {ReviewDialogComponent} from '../../../subject/review-dialog/review-dialog.component';
import {map, take} from 'rxjs/operators';
import {LayoutService} from '../layout/layout.service';
import {DeviceWidth} from '../../enums/device-width.enum';
import {Observable} from 'rxjs/internal/Observable';

@Injectable({
  providedIn: 'root'
})
export class ReviewDialogService {

  constructor(private reviewDialog: MatDialog,
              private layoutService: LayoutService
  ) {
  }

  static createDialogConfig<D = any>(reviewDialogData: ReviewDialogData, deviceWidth: DeviceWidth): any {
    const reviewDialogConfig = {
      data: reviewDialogData,
      autoFocus: false
    };


    if (LayoutService.ltSm(deviceWidth)) {
      const dialogFullScreenConfig = {
        width: '100%',
        height: '100%',
        maxWidth: '100vw',
        maxHeight: '100vh',
      };

      Object.assign(reviewDialogConfig, dialogFullScreenConfig);
    }

    return reviewDialogConfig;
  }


  public openReviewDialog(reviewDialogData: ReviewDialogData): Observable<any> {

    return this.layoutService.deviceWidth
      .pipe(
        take(1),
        map(deviceWidth => {
          const reviewDialogConfig = ReviewDialogService.createDialogConfig<ReviewDialogData>(reviewDialogData, deviceWidth);
          return this.reviewDialog.open(ReviewDialogComponent, reviewDialogConfig);
        }))
      ;


  }


}