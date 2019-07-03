import {Component, Inject, OnInit} from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';

@Component({
  selector: 'app-stop-crawling-explanation-dialog',
  templateUrl: './stop-crawling-explanation-dialog.component.html',
  styleUrls: ['./stop-crawling-explanation-dialog.component.scss']
})
export class StopCrawlingExplanationDialogComponent implements OnInit {

  constructor(public dialogRef: MatDialogRef<StopCrawlingExplanationDialogComponent>,
              @Inject(MAT_DIALOG_DATA) public data: any) { }

  ngOnInit() {
  }

}
