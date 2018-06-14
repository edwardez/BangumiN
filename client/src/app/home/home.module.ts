import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {BangumiCollectionService} from '../shared/services/bangumi/bangumi-collection.service';
import {ProgressModule} from './progress/progress.module';

@NgModule({
  imports: [
    CommonModule,
    ProgressModule
  ],
  declarations: [

  ],
  providers: [
    BangumiCollectionService
  ]
})
export class BanguminHomeModule {
}
