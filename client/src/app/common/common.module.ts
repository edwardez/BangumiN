import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { StarRatingComponent } from './star-rating/star-rating.component';
import {MaterialFlexModule} from '../../material-flex.module';

@NgModule({
  imports: [
    CommonModule,
    MaterialFlexModule
  ],
  declarations: [
  StarRatingComponent],
  providers: [

  ],
  exports: [
    StarRatingComponent
  ]
})
export class BanguminCommonComponentModule { }
