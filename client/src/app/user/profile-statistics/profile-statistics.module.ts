import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';

import {ProfileStatisticsRoutingModule} from './profile-statistics-routing.module';
import {NgxChartsModule} from '@swimlane/ngx-charts';
import {ProfileStatisticsComponent} from './profile-statistics.component';
import {BanguminSharedModule} from '../../bangumin-shared.module';
import {ReactiveFormsModule} from '@angular/forms';
import {LoadingSpinnerModule} from '../../common/loading-spinner/loading-spinner.module';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule,
    ProfileStatisticsRoutingModule,
    NgxChartsModule,
    ReactiveFormsModule,
    LoadingSpinnerModule
  ],
  declarations: [
    ProfileStatisticsComponent,
  ]
})
export class ProfileStatisticsModule {
}
