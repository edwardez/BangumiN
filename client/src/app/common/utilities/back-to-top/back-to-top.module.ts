import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {BackToTopComponent} from './back-to-top.component';
import {BanguminSharedModule} from '../../../bangumin-shared.module';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule
  ],
  declarations: [
    BackToTopComponent
  ],
  exports: [
    BackToTopComponent
  ]
})
export class BackToTopModule {
}
