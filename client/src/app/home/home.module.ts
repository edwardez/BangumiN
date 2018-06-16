import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {ProgressModule} from './progress/progress.module';
import {BanguminProfileModule} from './profile/bangumin-profile.module';

@NgModule({
  imports: [
    CommonModule,
    ProgressModule,
    BanguminProfileModule,
  ],
  declarations: [

  ],
  providers: [
  ]
})
export class BanguminHomeModule {
}
