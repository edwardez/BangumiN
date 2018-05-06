import {Component, Inject, OnDestroy, OnInit} from '@angular/core';
import {MAT_DIALOG_DATA, MatChipInputEvent, MatDialogRef} from '@angular/material';
import {SingleSubjectComponent} from '../single-subject.component';
import {_} from '../../../shared/utils/translation-marker';
import {SubjectType} from '../../../shared/enums/subject-type.enum';
import {FormBuilder, FormControl, FormArray, FormGroup, FormGroupDirective, NgForm, Validators} from '@angular/forms';
import {ErrorStateMatcher} from '@angular/material/core';
import {ENTER, COMMA, SPACE} from '@angular/cdk/keycodes';
import {environment} from '../../../../environments/environment';
import {BangumiCollectionService} from '../../../shared/services/bangumi/bangumi-collection.service';
import {Subject} from 'rxjs/Subject';
import {CollectionRequest} from '../../../shared/models/collection/collection-request';
import {map, startWith, takeUntil} from 'rxjs/operators';
import {Observable} from 'rxjs/Observable';

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
export class ReviewDialogComponent implements OnInit, OnDestroy {

  private ngUnsubscribe: Subject<void> = new Subject<void>();
  private ratingForm: FormGroup;
  private matcher = new InstantStateMatcher();


  separatorKeysCodes = [ENTER, COMMA, SPACE];

  private readonly commentMaxLength: number;
  private readonly tagsMaxNumber: number;

  constructor(public dialogRef: MatDialogRef<SingleSubjectComponent>,
              private formBuilder: FormBuilder,
              @Inject(MAT_DIALOG_DATA) public data: any,
              private bangumiCollectionService: BangumiCollectionService) {
    this.commentMaxLength = environment.commentMaxLength;
    this.tagsMaxNumber = environment.tagsMaxNumber;
    this.createForm();
  }

  ngOnInit() {

  }

  ngOnDestroy(): void {
    // unsubscribe
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

  createForm() {
    this.ratingForm = this.formBuilder.group(
      {
        'rating': [<number>this.data.rating],
        'tag': '',
        'tagsArray': this.formBuilder.array(this.data.tags,  Validators.maxLength(10)),
        'collectionStatus': [<string>this.data.statusType],
        'comment': [<string>this.data.comment, Validators.maxLength(this.commentMaxLength)]
      }
    );
  }


  onSubmit() {
    const ratingModel = this.ratingForm.value;

    const collectionRequest: CollectionRequest = new CollectionRequest(
      ratingModel.collectionStatus, ratingModel.comment, '', ratingModel.rating, 0);


    this.bangumiCollectionService.upsertSubjectCollectionStatus(this.data.subjectId, collectionRequest).pipe(
      takeUntil(this.ngUnsubscribe)
    ).subscribe( res => {
      this.dialogRef.close(this.data);
    });

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

  onAddTags(event: MatChipInputEvent) {
    const input = event.input;
    const value = event.value;
    // Add tag
    if ((value || '').trim() && this.tagsArray.value.indexOf(value) === -1) {
      this.tagsArray.push(new FormControl(value));
    }

    // Reset the input value
    if (input) {
      input.value = '';
    }

  }

  onRemoveTags(tag: any) {

    this.tagsArray.removeAt(this.tagsArray.value.indexOf(tag))
  }



  get collectionStatus() {return this.ratingForm.get('collectionStatus'); }
  get rating() {return this.ratingForm.get('rating'); }
  get comment() {return this.ratingForm.get('comment'); }
  get tag() {return this.ratingForm.get('tag'); }
  get tagsArray(): FormArray {
    return this.ratingForm.get('tagsArray') as FormArray;
  }





}
