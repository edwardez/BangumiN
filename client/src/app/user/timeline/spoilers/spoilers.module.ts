import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {SpoilerOverviewComponent} from './spoiler-overview/spoiler-overview.component';
import {SpoilersRoutingModule} from './spoilers-routing.module';
import {BanguminSharedModule} from '../../../bangumin-shared.module';
import {SpoilerSingleModule} from './spoiler-single/spoiler-single.module';
import {QuillModule} from 'ngx-quill';

@NgModule({
  imports: [
    CommonModule,
    QuillModule,
    BanguminSharedModule,
    SpoilersRoutingModule,
    SpoilerSingleModule
  ],
  declarations: [SpoilerOverviewComponent]
})
export class SpoilersModule {
}
