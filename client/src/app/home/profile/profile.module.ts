import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {NgxChartsModule} from '@swimlane/ngx-charts';
import { StatsComponent } from './stats/stats.component';

@NgModule({
  imports: [
    CommonModule,
    NgxChartsModule
  ],
  declarations: [StatsComponent],
  exports: [
    StatsComponent
  ]
})
export class ProfileModule { }
