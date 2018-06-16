import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {FullSearchComponent} from './full-search/full-search.component';
import {BanguminSharedModule} from '../../bangumin-shared.module';
import {RouterModule} from '@angular/router';
import {SharedPipeModule} from '../shared/pipe/shared-pipe.module';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule,
    RouterModule,
    SharedPipeModule
  ],
  declarations: [
    FullSearchComponent,

  ]
})
export class BanguminSearchModule {
}
