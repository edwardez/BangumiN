import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {BanguminSharedModule} from '../bangumin-shared.module';
import {RouterModule} from '@angular/router';
import {SharedPipeModule} from '../shared/pipe/shared-pipe.module';
import {NavSearchBarModule} from './nav-search-bar/nav-search-bar.module';

import {UserSearchComponent} from './user-search/user-search.component';
import {SubjectSearchComponent} from './subject-search/subject-search.component';
import {SearchResultComponent} from './search-result/search-result.component';
import {LoadingSpinnerModule} from '../common/loading-spinner/loading-spinner.module';
import {InfiniteScrollModule} from 'ngx-infinite-scroll';
import {BackToTopModule} from '../common/utilities/back-to-top/back-to-top.module';
import {StarRatingModule} from '../common/star-rating/star-rating.module';
import {UserSearchCardContentComponent} from './user-search/user-search-card-content/user-search-card-content.component';
import {ReactiveFormsModule} from '@angular/forms';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule,
    RouterModule,
    ReactiveFormsModule,
    InfiniteScrollModule,
    SharedPipeModule,
    NavSearchBarModule,
    LoadingSpinnerModule,
    BackToTopModule,
    StarRatingModule
  ],
  declarations: [
    UserSearchComponent,
    SubjectSearchComponent,
    SearchResultComponent,
    UserSearchCardContentComponent,

  ]
})
export class BanguminSearchModule {
}
