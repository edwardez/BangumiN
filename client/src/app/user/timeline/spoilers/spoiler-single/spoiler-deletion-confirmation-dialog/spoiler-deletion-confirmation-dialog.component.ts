import {Component, Inject, OnInit} from '@angular/core';
import {MAT_DIALOG_DATA, MatDialogRef} from '@angular/material';
import {SpoilerExisted} from '../../../../../shared/models/spoiler/spoiler-existed';
import {BanguminSpoilerService} from '../../../../../shared/services/bangumin/bangumin-spoiler.service';

@Component({
  selector: 'app-spoiler-deletion-confirmation-dialog',
  templateUrl: './spoiler-deletion-confirmation-dialog.component.html',
  styleUrls: ['./spoiler-deletion-confirmation-dialog.component.scss']
})
export class SpoilerDeletionConfirmationDialogComponent implements OnInit {

  constructor(
    public banguminSpoilerService: BanguminSpoilerService,
    public dialogRef: MatDialogRef<SpoilerDeletionConfirmationDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public spoilerExisted: SpoilerExisted) {
  }

  ngOnInit() {
  }

  onCancelClick() {
    this.dialogRef.close();
  }

  onConfirmClick() {
    this.banguminSpoilerService.deleteSpoiler(this.spoilerExisted.spoilerId, String(this.spoilerExisted.userId))
      .subscribe(
        res => {
          this.dialogRef.close();
          // TODO: handle logic after deleting
          window.location.reload();
        }
      );
  }

}
