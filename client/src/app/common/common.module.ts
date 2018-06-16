import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {StarRatingComponent} from './star-rating/star-rating.component';
import {BanguminSharedModule} from '../../bangumin-shared.module';
import {NavComponent} from './nav/nav.component';
import {SideNavContentComponent} from './side-nav-content/side-nav-content.component';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule
  ],
  declarations: [
    StarRatingComponent,
    NavComponent,
    SideNavContentComponent
  ],
  providers: [],
  exports: [
    StarRatingComponent,
    NavComponent,
    SideNavContentComponent
  ]
})
export class BanguminCommonComponentModule {
}
