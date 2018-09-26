import {Component, Inject, OnDestroy, OnInit} from '@angular/core';
import {MAT_DIALOG_DATA, MatChipInputEvent, MatDialogRef} from '@angular/material';
import {SingleSubjectComponent} from '../single-subject/single-subject.component';
import {SubjectType} from '../../shared/enums/subject-type.enum';
import {FormArray, FormBuilder, FormControl, FormGroup, FormGroupDirective, NgForm, Validators} from '@angular/forms';
import {ErrorStateMatcher} from '@angular/material/core';
import {COMMA, ENTER, SPACE} from '@angular/cdk/keycodes';
import {environment} from '../../../environments/environment';
import {BangumiCollectionService} from '../../shared/services/bangumi/bangumi-collection.service';
import {Subject} from 'rxjs';
import {CollectionRequest} from '../../shared/models/collection/collection-request';
import {catchError, finalize, take, takeUntil} from 'rxjs/operators';
import {SnackBarService} from '../../shared/services/snackBar/snack-bar.service';
import {ReviewDialogData} from '../../shared/models/review/reviewDialogData';
import {CollectionResponse} from '../../shared/models/collection/collection-response';

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


  subjectType: string;
  duringSubmit = false;
  collectionResponse: CollectionResponse;
  ratingForm: FormGroup;
  separatorKeysCodes = [ENTER, COMMA, SPACE];
  matcher = new InstantStateMatcher();

  readonly commentMaxLength: number;
  readonly tagsMaxNumber: number;

  private ngUnsubscribe: Subject<void> = new Subject<void>();

  constructor(public dialogRef: MatDialogRef<SingleSubjectComponent>,
              private formBuilder: FormBuilder,
              @Inject(MAT_DIALOG_DATA) public data: ReviewDialogData,
              private bangumiCollectionService: BangumiCollectionService,
              private snackBarService: SnackBarService) {
    this.commentMaxLength = environment.commentMaxLength;
    this.tagsMaxNumber = environment.tagsMaxNumber;
    this.subjectType = SubjectType[data.subject.type];
    this.bangumiCollectionService.getSubjectCollectionStatus(this.data.subject.id).subscribe(collectionResponse => {
      this.collectionResponse = collectionResponse;
      this.initializeRatingForm(collectionResponse);
    });
  }

  get collectionStatus() {
    return this.ratingForm.get('collectionStatus');
  }

  get rating() {
    return this.ratingForm.get('rating');
  }

  get comment() {
    return this.ratingForm.get('comment');
  }

  get tag() {
    return this.ratingForm.get('tag');
  }

  get tagsArray(): FormArray {
    return this.ratingForm.get('tagsArray') as FormArray;
  }

  ngOnInit() {

  }

  ngOnDestroy(): void {
    // unsubscribe
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

  initializeRatingForm(collectionResponse: CollectionResponse) {
    this.ratingForm = this.formBuilder.group(
      {
        'rating': [<number>collectionResponse.rating],
        'tag': '',
        'tagsArray': this.formBuilder.array(collectionResponse.tags, Validators.maxLength(10)),
        'collectionStatus': [<string>collectionResponse.status.type],
        'comment': [<string>collectionResponse.comment, Validators.maxLength(this.commentMaxLength)],
        'privacy': <boolean>(collectionResponse.privacy.toString() !== '0'),
      }
    );
  }

  onSubmit() {
    this.duringSubmit = true;
    const ratingModel = this.ratingForm.value;

    const collectionRequest: CollectionRequest = new CollectionRequest(
      ratingModel.collectionStatus, ratingModel.comment, ratingModel.tagsArray, ratingModel.rating, ratingModel.privacy === false ? 0 : 1);


    this.bangumiCollectionService.upsertSubjectCollectionStatus(this.data.subject.id, collectionRequest).pipe(
      catchError(error => {
        this.snackBarService.openSimpleSnackBar('common.snackBar.error.submit.general')
          .pipe(take(1)).subscribe(() => {
        });
        return error;
      }),
      finalize(() => {
        this.duringSubmit = false;
      }),
      takeUntil(this.ngUnsubscribe),
    ).subscribe(res => {
      this.dialogRef.close(res);
    });

  }

  onCancelSubmit() {

  }

  onRatingChanged(rating) {

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
    // remove tag at the specific index, since tags are unique we can just delete the first one
    this.tagsArray.removeAt(this.tagsArray.value.indexOf(tag));
  }


}
