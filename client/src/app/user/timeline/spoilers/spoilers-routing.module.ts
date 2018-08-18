import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {SpoilerOverviewComponent} from './spoiler-overview/spoiler-overview.component';

const routes: Routes = [
  {
    path: '',
    component: SpoilerOverviewComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SpoilersRoutingModule {
}
