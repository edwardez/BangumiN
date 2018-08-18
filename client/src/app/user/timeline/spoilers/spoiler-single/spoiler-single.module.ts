import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {BanguminSharedModule} from '../../../../bangumin-shared.module';
import {SpoilerSingleWrapperComponent} from './spoiler-single-wrapper/spoiler-single-wrapper.component';
import {SpoilerSingleContentComponent} from './spoiler-single-content/spoiler-single-content.component';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule
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
