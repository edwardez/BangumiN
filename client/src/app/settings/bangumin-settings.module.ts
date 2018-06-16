import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {SettingsComponent} from './settings.component';
import {BanguminSharedModule} from '../../bangumin-shared.module';
import {SharedPipeModule} from '../shared/pipe/shared-pipe.module';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';

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
  ]
})
export class BanguminSettingsModule {
}
