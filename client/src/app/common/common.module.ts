import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {StarRatingComponent} from './star-rating/star-rating.component';
import {MaterialLayoutCommonModule} from '../../material-layout-common.module';

@NgModule({
    imports: [
        CommonModule,
        MaterialLayoutCommonModule
    ],
    declarations: [
        StarRatingComponent],
    providers: [],
    exports: [
        StarRatingComponent
    ]
})
export class BanguminCommonComponentModule {
}
