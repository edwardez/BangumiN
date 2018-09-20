import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {SubjectStatisticsComponent} from './subject-statistics.component';

const routes: Routes = [
  {
    path: '',
    component: SubjectStatisticsComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SubjectStatisticsRoutingModule {
}
