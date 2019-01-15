import {RouterModule, Routes} from '@angular/router';
import {NgModule} from '@angular/core';
import {SummaryHomeComponent} from './summary-home/summary-home.component';

const routes: Routes = [
  {
    path: '2018/:userId',
    component: SummaryHomeComponent,
  },
  {
    path: '2018',
    component: SummaryHomeComponent,
  },
  {
    path: '**',
    redirectTo: './2018',
    pathMatch: 'full'
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SummaryRoutingModule {
}
