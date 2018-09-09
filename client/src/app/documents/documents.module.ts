import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {BanguminSharedModule} from '../bangumin-shared.module';
import {HelpHomeComponent} from './help/help-home/help-home.component';
import {AboutHomeComponent} from './about/about-home/about-home.component';
import {PrivacyComponent} from './privacy/privacy.component';
import {TosComponent} from './tos/tos.component';
import {PageNotFoundModule} from '../common/page-not-found/page-not-found.module';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule,
    PageNotFoundModule
  ],
  declarations: [HelpHomeComponent, AboutHomeComponent, PrivacyComponent, TosComponent]
})
export class DocumentsModule {
}
