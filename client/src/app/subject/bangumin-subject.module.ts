import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {SharedPipeModule} from '../shared/pipe/shared-pipe.module';
import {BanguminSharedModule} from '../bangumin-shared.module';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {SingleSubjectComponent} from './single-subject/single-subject.component';
import {ReviewDialogComponent} from './review-dialog/review-dialog.component';
import {StarRatingModule} from '../common/star-rating/star-rating.module';
import {CharacterListComponent} from './character-list/character-list.component';
import {StaffListComponent} from './staff-list/staff-list.component';
import {ScoreSpinnerComponent} from './score-spinner/score-spinner.component';
import {SubjectEpisodeComponent} from './subject-episode/subject-episode.component';
import {SubjectComponent} from './subject.component';
import {LoadingSpinnerModule} from '../common/loading-spinner/loading-spinner.module';
import { SubjectSpoilerCreationComponent } from './subject-spoiler-creation/subject-spoiler-creation.component';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule,
    SharedPipeModule,
    FormsModule,
    ReactiveFormsModule,
    StarRatingModule,
    LoadingSpinnerModule
  ],
  declarations: [
    SingleSubjectComponent,
    ReviewDialogComponent,
    CharacterListComponent,
    StaffListComponent,
    ScoreSpinnerComponent,
    SubjectEpisodeComponent,
    SubjectComponent,
    SubjectSpoilerCreationComponent,
  ],
  entryComponents: [
    ReviewDialogComponent
  ]
})
export class BanguminSubjectModule {
}
