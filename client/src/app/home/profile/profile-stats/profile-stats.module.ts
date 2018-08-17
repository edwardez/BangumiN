import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';

import {ProfileStatsRoutingModule} from './profile-stats-routing.module';
// import {NgxChartsModule} from '@swimlane/ngx-charts';
import {BarChartModule, LineChartModule} from '@swimlane/ngx-charts';
import {ProfileStatsComponent} from './profile-stats.component';
import {BanguminSharedModule} from '../../../../bangumin-shared.module';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule,
    ProfileStatsRoutingModule,
    // NgxChartsModule,
    LineChartModule,
    BarChartModule
  ],
  declarations: [
    ProfileStatsComponent,
  ]
})
export class ProfileStatsModule {
}
