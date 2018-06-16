import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {NgxChartsModule} from '@swimlane/ngx-charts';
import { StatsComponent } from './stats/stats.component';
import {CollectionByTypeComponent} from './collection/collection-by-type/collection-by-type.component';
import {ProfileComponent} from './profile.component';
import {BanguminSharedModule} from '../../../bangumin-shared.module';

@NgModule({
  imports: [
    CommonModule,
    NgxChartsModule,
    BanguminSharedModule
  ],
  declarations: [
    StatsComponent,
    ProfileComponent,
    CollectionByTypeComponent,
  ],
  exports: [
  ]
})
export class BanguminProfileModule { }
