import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {NavSearchBarComponent} from './nav-search-bar.component';
import {BanguminSharedModule} from '../../bangumin-shared.module';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule,
  ],
  declarations: [
    NavSearchBarComponent
  ],
  exports: [
    NavSearchBarComponent
  ]
})
export class NavSearchBarModule {
}
