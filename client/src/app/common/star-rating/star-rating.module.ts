import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {StarRatingComponent} from './star-rating.component';
import {BanguminSharedModule} from '../../bangumin-shared.module';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule
  ],
  declarations: [
    StarRatingComponent
  ],
  exports: [
    StarRatingComponent
  ]
})
export class StarRatingModule {
}
