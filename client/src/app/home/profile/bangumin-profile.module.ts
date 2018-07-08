import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {NgxChartsModule} from '@swimlane/ngx-charts';
import {CollectionByTypeComponent} from './collection/collection-by-type/collection-by-type.component';
import {ProfileComponent} from './profile.component';
import {BanguminSharedModule} from '../../../bangumin-shared.module';
import {ProfileStatsComponent} from './profile-stats/profile-stats.component';
import {MatButtonModule} from "@angular/material/button";

@NgModule({
  imports: [
    CommonModule,
    NgxChartsModule,
    BanguminSharedModule,
    MatButtonModule
  ],
  declarations: [
    ProfileComponent,
    CollectionByTypeComponent,
    ProfileStatsComponent,
  ],
  exports: [
    MatButtonModule
  ]
})
export class BanguminProfileModule {
}
