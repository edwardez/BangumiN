import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {CollectionByTypeComponent} from './collection/collection-by-type/collection-by-type.component';
import {ProfileComponent} from './profile.component';
import {BanguminSharedModule} from '../../../bangumin-shared.module';
import {CollectionHomeComponent} from './collection/collection-home/collection-home.component';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule
  ],
  declarations: [
    ProfileComponent,
    CollectionByTypeComponent,
    CollectionHomeComponent,
  ],
  exports: []
})
export class BanguminProfileModule {
}
