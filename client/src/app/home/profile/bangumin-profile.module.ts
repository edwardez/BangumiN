import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {NgxChartsModule} from '@swimlane/ngx-charts';
import {CollectionByTypeComponent} from './collection/collection-by-type/collection-by-type.component';
import {ProfileComponent} from './profile.component';
import {BanguminSharedModule} from '../../../bangumin-shared.module';
import {ProfileStatsComponent} from './profile-stats/profile-stats.component';

@NgModule({
  imports: [
    CommonModule,
    NgxChartsModule,
    BanguminSharedModule
  ],
  declarations: [
    ProfileComponent,
    CollectionByTypeComponent,
    ProfileStatsComponent,
  ],
  exports: []
})
export class BanguminProfileModule {
}
