import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {BanguminSharedModule} from '../../../../bangumin-shared.module';
import {SpoilerSingleWrapperComponent} from './spoiler-single-wrapper/spoiler-single-wrapper.component';
import {SpoilerSingleContentComponent} from './spoiler-single-content/spoiler-single-content.component';
import {PageNotFoundModule} from '../../../../common/page-not-found/page-not-found.module';
import {ShareBottomSheetComponent} from './share-bottom-sheet/share-bottom-sheet.component';
import {ClipboardModule} from 'ngx-clipboard';
import {ShareSpoilerMenuComponent} from './share-spoiler-menu/share-spoiler-menu.component';
// tslint:disable-next-line:max-line-length
import {SpoilerDeletionConfirmationDialogComponent} from './spoiler-deletion-confirmation-dialog/spoiler-deletion-confirmation-dialog.component';

@NgModule({
  imports: [
    CommonModule,
    BanguminSharedModule,
    PageNotFoundModule,
    ClipboardModule
  ],
  declarations: [
    SpoilerSingleWrapperComponent,
    SpoilerSingleContentComponent,
    ShareBottomSheetComponent,
    ShareSpoilerMenuComponent,
    SpoilerDeletionConfirmationDialogComponent
  ],
  exports: [
    SpoilerSingleWrapperComponent,
    SpoilerSingleContentComponent
  ],
  entryComponents: [
    ShareBottomSheetComponent,
    SpoilerDeletionConfirmationDialogComponent
  ],
})
export class SpoilerSingleModule {
}
