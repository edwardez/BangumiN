import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {BanguminSharedModule} from '../bangumin-shared.module';
import {SpoilerSingleModule} from './timeline/spoilers/spoiler-single/spoiler-single.module';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule,
    SpoilerSingleModule
  ],
  declarations: [
    // ProfileComponent,
    // CollectionByTypeComponent,
    // CollectionHomeComponent
  ],
  exports: []
})
export class BanguminProfileModule {
}
