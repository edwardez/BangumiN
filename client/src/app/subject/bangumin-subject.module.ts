import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {SharedPipeModule} from '../shared/pipe/shared-pipe.module';
import {BanguminSharedModule} from '../../bangumin-shared.module';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {SingleSubjectComponent} from './single-subject/single-subject.component';
import {ReviewDialogComponent} from './review-dialog/review-dialog.component';
import {StarRatingComponent} from '../common/star-rating/star-rating.component';
import {StarRatingModule} from '../common/star-rating/star-rating.module';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule,
    SharedPipeModule,
    FormsModule,
    ReactiveFormsModule,
    StarRatingModule
  ],
  declarations: [
    SingleSubjectComponent,
    ReviewDialogComponent
  ],
  entryComponents: [
    ReviewDialogComponent
  ]
})
export class BanguminSubjectModule { }
