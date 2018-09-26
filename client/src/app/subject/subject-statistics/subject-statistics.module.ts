import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {BanguminSharedModule} from '../../bangumin-shared.module';
import {NgxChartsModule} from '@swimlane/ngx-charts';
import {SubjectStatisticsComponent} from './subject-statistics.component';
import {SubjectStatisticsRoutingModule} from './subject-statistics-routing.module';
import {ReactiveFormsModule} from '@angular/forms';
import {LoadingSpinnerModule} from '../../common/loading-spinner/loading-spinner.module';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule,
    NgxChartsModule,
    SubjectStatisticsRoutingModule,
    ReactiveFormsModule,
    LoadingSpinnerModule
  ],
  declarations: [
    SubjectStatisticsComponent
  ]
})
export class SubjectStatisticsModule {
}
