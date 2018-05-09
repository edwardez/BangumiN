import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {BangumiCollectionService} from '../shared/services/bangumi/bangumi-collection.service';

@NgModule({
  imports: [
    CommonModule
  ],
  declarations: [
  ],
  providers: [
    BangumiCollectionService
  ]
})
export class BanguminHomeModule { }
