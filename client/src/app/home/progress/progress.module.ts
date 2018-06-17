import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {ProgressPlaceholderComponent} from './progress-placeholder/progress-placeholder.component';
import {ProgressContentComponent} from './progress-content/progress-content.component';
import {ProgressComponent} from './progress.component';
import {ProgressByTypeComponent} from './progress-by-type/progress-by-type.component';
import {RouterModule} from '@angular/router';
import {EpisodeDialogComponent} from './episode-dialog/episode-dialog.component';
import {BanguminSharedModule} from '../../../bangumin-shared.module';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {ProgessBySubjectComponent} from './progess-by-subject/progess-by-subject.component';

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
    EpisodeDialogComponent,
    ProgessBySubjectComponent
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
