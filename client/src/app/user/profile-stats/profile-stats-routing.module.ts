import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {ProfileStatsComponent} from './profile-stats.component';

const routes: Routes = [
  {
    path: '',
    component: ProfileStatsComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ProfileStatsRoutingModule {
}
