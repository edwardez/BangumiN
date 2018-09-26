import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {BanguminSharedModule} from '../bangumin-shared.module';
import {NavComponent} from './nav/nav.component';
import {SideNavContentComponent} from './side-nav-content/side-nav-content.component';
import {FooterComponent} from './footer/footer.component';
import {NavSearchBarModule} from '../search/nav-search-bar/nav-search-bar.module';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule,
    NavSearchBarModule
  ],
  declarations: [
    NavComponent,
    SideNavContentComponent,
    FooterComponent,
  ],
  providers: [],
  exports: [
    NavComponent,
    SideNavContentComponent,
  ]
})
export class BanguminCommonComponentModule {
}
