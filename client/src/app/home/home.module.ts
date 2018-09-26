import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {BanguminProfileModule} from '../user/bangumin-profile.module';
import {BanguminSharedModule} from '../bangumin-shared.module';
import {WelcomeComponent} from './welcome/welcome.component';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule,
    // ProgressModule,
    BanguminProfileModule,
  ],
  declarations: [WelcomeComponent],
  providers: []
})
export class BanguminHomeModule {
}
