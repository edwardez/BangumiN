import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {SharedPipeModule} from '../shared/pipe/shared-pipe.module';
import {BanguminSharedModule} from '../../bangumin-shared.module';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {SingleSubjectComponent} from './single-subject/single-subject.component';
import {ReviewDialogComponent} from './review-dialog/review-dialog.component';
import {StarRatingModule} from '../common/star-rating/star-rating.module';
import {CharacterListComponent} from './character-list/character-list.component';
import {StaffListComponent} from './staff-list/staff-list.component';
import {ScoreSpinnerComponent} from './score-spinner/score-spinner.component';
import {SubjectEpisodeComponent} from './subject-episode/subject-episode.component';
import {SubjectComponent} from './subject.component';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule,
    SharedPipeModule,
    FormsModule,
    ReactiveFormsModule,
    StarRatingModule
  ],
  declarations: [
    SingleSubjectComponent,
    ReviewDialogComponent,
    CharacterListComponent,
    StaffListComponent,
    ScoreSpinnerComponent,
    SubjectEpisodeComponent,
    SubjectComponent,
  ],
  entryComponents: [
    ReviewDialogComponent
  ]
})
export class BanguminSubjectModule {
}
