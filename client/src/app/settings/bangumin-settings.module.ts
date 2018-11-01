import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {SettingsComponent} from './settings.component';
import {BanguminSharedModule} from '../bangumin-shared.module';
import {SharedPipeModule} from '../shared/pipe/shared-pipe.module';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import { StopCrawlingExplanationDialogComponent } from './stop-crawling-explanation-dialog/stop-crawling-explanation-dialog.component';


@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule,
    SharedPipeModule,
    FormsModule,
    ReactiveFormsModule
  ],
  declarations: [
    SettingsComponent,
    StopCrawlingExplanationDialogComponent,

  ],
  entryComponents: [StopCrawlingExplanationDialogComponent],
})
export class BanguminSettingsModule {
}
