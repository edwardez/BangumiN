import {Component, Inject, OnInit} from '@angular/core';
import {SpoilerExisted} from '../../../../../shared/models/spoiler/spoiler-existed';
import {Observable, of} from 'rxjs';
import { MAT_BOTTOM_SHEET_DATA, MatBottomSheetRef } from '@angular/material/bottom-sheet';
import { MatDialog } from '@angular/material/dialog';
import {CopyEvent, ShareableStringGeneratorService} from '../../../../../shared/services/utils/shareable-string-generator.service';
import {AuthenticationService} from '../../../../../shared/services/auth.service';
import {map, take} from 'rxjs/operators';
import {SpoilerDeletionConfirmationDialogComponent} from '../spoiler-deletion-confirmation-dialog/spoiler-deletion-confirmation-dialog.component';


interface ShareableSpoilerData {
  spoilerLink: string;
  spoilerContent: SpoilerExisted;
}

@Component({
  selector: 'app-share-bottom-sheet',
  templateUrl: './share-bottom-sheet.component.html',
  styleUrls: ['./share-bottom-sheet.component.scss']
})
export class ShareBottomSheetComponent implements OnInit {

  spoilerLink: string;
  twitterShareLink: Observable<string>;
  weiboShareLink: Observable<string>;
  copyableText: Observable<string>;
  canDelete: Observable<boolean>;

  constructor(
    private authenticationService: AuthenticationService,
    private shareableStringGeneratorService: ShareableStringGeneratorService,
    private dialog: MatDialog,
    private bottomSheetRef: MatBottomSheetRef<ShareBottomSheetComponent>,
    @Inject(MAT_BOTTOM_SHEET_DATA) public shareableSpoilerData: ShareableSpoilerData) {
  }


  ngOnInit() {
    const spoilerLink = this.shareableSpoilerData.spoilerLink;
    this.spoilerLink = this.shareableSpoilerData.spoilerLink;
    const spoilerContent = this.shareableSpoilerData.spoilerContent;

    const relatesSubjectsNames: string[] =
      (spoilerContent.relatedSubjectsBaseDetails || []).map(
        relatedSubjectBase => relatedSubjectBase.subjectName.preferred);
    this.twitterShareLink =
      this.shareableStringGeneratorService.generateTwitterShareLink(relatesSubjectsNames, spoilerLink,
        spoilerContent.spoilerText);
    this.weiboShareLink =
      this.shareableStringGeneratorService.generateWeiboShareLink(relatesSubjectsNames, spoilerLink,
        spoilerContent.spoilerText);
    this.copyableText = this.shareableStringGeneratorService.generateCopyableText(relatesSubjectsNames, spoilerLink,
      spoilerContent.spoilerText);
    this.canDelete = this.authenticationService.userSubject.pipe(
      map(userSubject => {
        if (userSubject) {
          return userSubject.id === Number(spoilerContent.userId);
        }
        return false;
      }),
      take(1)
    );

  }

  handleCopyCallback(event: CopyEvent, text: Observable<string> | string) {
    this.shareableStringGeneratorService.handleCopyCallback(event, text instanceof Observable ? text : of(text), this.spoilerLink)
      .subscribe(res => {
        this.bottomSheetRef.dismiss();
      });
  }

  deleteSpoiler() {
    const dialogRef = this.dialog.open(SpoilerDeletionConfirmationDialogComponent, {
      data: this.shareableSpoilerData.spoilerContent
    });
    dialogRef.afterClosed().subscribe(res => {
      this.dismissSheet();
    });
  }

  dismissSheet(): void {
    this.bottomSheetRef.dismiss();
  }


}
