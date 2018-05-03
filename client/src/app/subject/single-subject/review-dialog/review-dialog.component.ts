import {Component, Inject, OnInit} from '@angular/core';
import {MAT_DIALOG_DATA, MatDialogRef} from '@angular/material';
import {SingleSubjectComponent} from '../single-subject.component';
import {_} from '../../../shared/utils/translation-marker';
import {SubjectType} from '../../../shared/enums/subject-type.enum';

@Component({
  selector: 'app-review-dialog',
  templateUrl: './review-dialog.component.html',
  styleUrls: ['./review-dialog.component.scss']
})
export class ReviewDialogComponent implements OnInit {


  constructor(public dialogRef: MatDialogRef<SingleSubjectComponent>,
              @Inject(MAT_DIALOG_DATA) public data: any) {
  }

  ngOnInit() {

  }

  onSubmitClick() {


  }

  /**
   * map a enum type into relevant string
   * @param {number} type
   * @returns {string}
   */
  getActionTypeName(type: number): string {
    switch (type) {
      case SubjectType.book : {
        return _('subject.tabs.overview.review.action.type.1');
      }
      case SubjectType.anime : {
        return _('subject.tabs.overview.review.action.type.2');
      }
      case SubjectType.music : {
        return _('subject.tabs.overview.review.action.type.3');
      }
      case SubjectType.game : {
        return _('subject.tabs.overview.review.action.type.4');
      }
      case SubjectType.real : {
        return _('subject.tabs.overview.review.action.type.6');
      }
      default : {
        return _('subject.tabs.overview.review.action.type.0');
      }
    }
  }


}
