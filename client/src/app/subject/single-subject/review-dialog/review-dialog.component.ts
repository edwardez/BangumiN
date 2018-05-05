import {Component, Inject, OnInit} from '@angular/core';
import {MAT_DIALOG_DATA, MatDialogRef} from '@angular/material';
import {SingleSubjectComponent} from '../single-subject.component';
import {_} from '../../../shared/utils/translation-marker';
import {SubjectType} from '../../../shared/enums/subject-type.enum';
import {FormBuilder, FormControl, FormGroup, FormGroupDirective, NgForm, Validators} from '@angular/forms';
import {ErrorStateMatcher} from '@angular/material/core';
import {environment} from '../../../../environments/environment';

/** Error when invalid control is dirty, touched, or submitted. */
export class InstantStateMatcher implements ErrorStateMatcher {
  isErrorState(control: FormControl | null, form: FormGroupDirective | NgForm | null): boolean {
    const isSubmitted = form && form.submitted;
    return (control && control.invalid && (control.dirty || control.touched || isSubmitted));
  }
}


@Component({
  selector: 'app-review-dialog',
  templateUrl: './review-dialog.component.html',
  styleUrls: ['./review-dialog.component.scss']
})
export class ReviewDialogComponent implements OnInit {




  ratingForm: FormGroup;
  matcher = new InstantStateMatcher();
  commentMaxLength: number;

  constructor(public dialogRef: MatDialogRef<SingleSubjectComponent>,
              private formBuilder: FormBuilder,
              @Inject(MAT_DIALOG_DATA) public data: any) {
    this.commentMaxLength = environment.commentMaxLength;
    this.ratingForm = this.formBuilder.group(
      {
        'rating': <number>this.data.rating,
        'collectionStatus': 0,
        'comment': ['', Validators.maxLength(this.commentMaxLength)]

      }
    );
  }

  ngOnInit() {

  }

  onSubmitClick() {
    this.dialogRef.close(this.data);
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

  onRatingChanged(rating) {
    this.data.rating = rating;
    this.ratingForm.patchValue(
      {
        'rating': rating
      }
    );
  }

  get collectionStatus() {return this.ratingForm.get('collectionStatus'); }
  get rating() {return this.ratingForm.get('rating'); }
  get comment() {return this.ratingForm.get('comment'); }



}
