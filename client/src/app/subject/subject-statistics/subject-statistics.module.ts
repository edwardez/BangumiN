import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {BanguminSharedModule} from '../../bangumin-shared.module';
import {NgxChartsModule} from '@swimlane/ngx-charts';
import {SubjectStatisticsComponent} from './subject-statistics.component';
import {SubjectStatisticsRoutingModule} from './subject-statistics-routing.module';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule,
    NgxChartsModule,
    SubjectStatisticsRoutingModule,
  ],
  declarations: [
    SubjectStatisticsComponent
  ]
})
export class SubjectStatisticsModule {
}
