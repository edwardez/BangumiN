import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {LoginBangumiComponent} from './login-bangumi/login-bangumi.component';
import {ActivateBangumiComponent} from './login-bangumi/activate-bangumi/activate-bangumi.component';
import {BangumiAuthWaitDialogComponent} from './login-bangumi/bangumi-auth-wait-dialog/bangumi-auth-wait-dialog.component';
import {BanguminSharedModule} from '../../bangumin-shared.module';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule
  ],
  declarations: [
    LoginBangumiComponent,
    ActivateBangumiComponent,
    BangumiAuthWaitDialogComponent,
  ],
  entryComponents: [
    BangumiAuthWaitDialogComponent
  ]
})
export class BanguminAuthModule { }
