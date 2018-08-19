import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {SpoilerOverviewComponent} from './spoiler-overview/spoiler-overview.component';
import {SpoilersRoutingModule} from './spoilers-routing.module';
import {BanguminSharedModule} from '../../../bangumin-shared.module';
import {SpoilerSingleModule} from './spoiler-single/spoiler-single.module';
import {QuillModule} from 'ngx-quill';
import {SpoilerCreationComponent} from './spoiler-creation/spoiler-creation.component';
import {ResponsiveDialogService} from '../../../shared/services/dialog/responsive-dialog.service';

@NgModule({
  imports: [
    CommonModule,
    QuillModule,
    BanguminSharedModule,
    SpoilersRoutingModule,
    SpoilerSingleModule
  ],
  declarations:
    [
      SpoilerOverviewComponent,
      SpoilerCreationComponent
    ],
  entryComponents:
    [
      SpoilerCreationComponent
    ],
  providers: [
    ResponsiveDialogService // TODO: use the root service instance after figuring out how to open lazy load dialog via a global service
  ]
})
export class SpoilersModule {
}
