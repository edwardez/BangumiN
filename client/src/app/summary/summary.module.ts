import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {BanguminSharedModule} from '../bangumin-shared.module';
import {SummaryHomeComponent} from './summary-home/summary-home.component';
import {SummaryRoutingModule} from './summary-routing.module';
import {UserSummaryComponent} from './user-summary/user-summary.component';
import {ReactiveFormsModule} from '@angular/forms';
import {InViewportModule} from 'ng-in-viewport';


@NgModule({
  declarations: [SummaryHomeComponent, UserSummaryComponent],
  imports: [
    BanguminSharedModule,
    CommonModule,
    InViewportModule,
    ReactiveFormsModule,
    SummaryRoutingModule,
  ]
})
export class SummaryModule {
}
