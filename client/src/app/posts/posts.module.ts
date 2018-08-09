import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';

import {PostsRoutingModule} from './posts-routing.module';
import {BanguminPostsComponent} from './bangumin-posts/bangumin-posts.component';
import {QuillModule} from 'ngx-quill';
import {BanguminSharedModule} from '../../bangumin-shared.module';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule,
    PostsRoutingModule,
    QuillModule
  ],
  declarations: [BanguminPostsComponent]
})
export class PostsModule {
}
