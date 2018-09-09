import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {BanguminSharedModule} from '../../../../bangumin-shared.module';
import {SpoilerSingleWrapperComponent} from './spoiler-single-wrapper/spoiler-single-wrapper.component';
import {SpoilerSingleContentComponent} from './spoiler-single-content/spoiler-single-content.component';
import {PageNotFoundModule} from '../../../../common/page-not-found/page-not-found.module';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule,
    PageNotFoundModule
  ],
  declarations: [
    SpoilerSingleWrapperComponent,
    SpoilerSingleContentComponent
  ],
  exports: [
    SpoilerSingleWrapperComponent,
    SpoilerSingleContentComponent
  ]
})
export class SpoilerSingleModule {
}
