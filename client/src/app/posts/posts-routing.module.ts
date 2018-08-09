import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {BanguminPostsComponent} from './bangumin-posts/bangumin-posts.component';

const routes: Routes = [
  {
    path: '',
    component: BanguminPostsComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PostsRoutingModule {
}
