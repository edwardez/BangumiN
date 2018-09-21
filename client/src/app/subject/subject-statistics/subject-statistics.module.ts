import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {BanguminSharedModule} from '../../bangumin-shared.module';
import {NgxChartsModule} from '@swimlane/ngx-charts';
import {SubjectStatisticsComponent} from './subject-statistics.component';
import {SubjectStatisticsRoutingModule} from './subject-statistics-routing.module';
import {ReactiveFormsModule} from '@angular/forms';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule,
    NgxChartsModule,
    SubjectStatisticsRoutingModule,
    ReactiveFormsModule
  ],
  declarations: [
    SubjectStatisticsComponent
  ]
})
export class SubjectStatisticsModule {
}
