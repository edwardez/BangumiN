import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {ProfileStatisticsComponent} from './profile-statistics.component';

const routes: Routes = [
  {
    path: '',
    component: ProfileStatisticsComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ProfileStatisticsRoutingModule {
}
