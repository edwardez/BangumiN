import {Component, Inject, OnInit} from '@angular/core';
import {MAT_DIALOG_DATA, MatDialogRef} from '@angular/material';

@Component({
  selector: 'app-bangumi-auth-wait-dialog',
  templateUrl: './bangumi-auth-wait-dialog.component.html',
  styleUrls: ['./bangumi-auth-wait-dialog.component.scss']
})
export class BangumiAuthWaitDialogComponent implements OnInit {

  constructor(public dialogRef: MatDialogRef<BangumiAuthWaitDialogComponent>,
              @Inject(MAT_DIALOG_DATA) public data: any) {
  }

  ngOnInit() {
    this.dialogRef.disableClose = true;
  }

  cancelAuth() {
    window.removeEventListener('message', this.data.receiveMessageHandler, false);
    this.dialogRef.close();
  }

}
