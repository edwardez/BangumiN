import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {ProgressPlaceholderComponent} from './progress-placeholder/progress-placeholder.component';
import {ProgressContentComponent} from './progress-content/progress-content.component';
import {ProgressComponent} from './progress.component';
import {ProgressByTypeComponent} from './progress-by-type/progress-by-type.component';
import {TranslateModule} from '@ngx-translate/core';
import {RouterModule} from '@angular/router';
import {EpisodeDialogComponent} from './episode-dialog/episode-dialog.component';
import {BanguminSharedModule} from '../../../bangumin-shared.module';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';

@NgModule({
  imports: [
    CommonModule,
    RouterModule,
    BanguminSharedModule,
    FormsModule,
    ReactiveFormsModule
  ],
  declarations: [
    ProgressComponent,
    ProgressByTypeComponent,
    ProgressPlaceholderComponent,
    ProgressContentComponent,
    EpisodeDialogComponent
  ],
  entryComponents: [
    EpisodeDialogComponent,
  ],
  exports: [
    ProgressComponent
  ]
})
export class ProgressModule {
}
