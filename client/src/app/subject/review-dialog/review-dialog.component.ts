import {Component, Inject, OnDestroy, OnInit} from '@angular/core';
import { MatChipInputEvent } from '@angular/material/chips';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import {SingleSubjectComponent} from '../single-subject/single-subject.component';
import {SubjectType} from '../../shared/enums/subject-type.enum';
import {FormArray, FormBuilder, FormControl, FormGroup, FormGroupDirective, NgForm, Validators} from '@angular/forms';
import {ErrorStateMatcher} from '@angular/material/core';
import {COMMA, ENTER, SPACE} from '@angular/cdk/keycodes';
import {environment} from '../../../environments/environment';
import {BangumiCollectionService} from '../../shared/services/bangumi/bangumi-collection.service';
import {Subject} from 'rxjs';
import {CollectionRequest} from '../../shared/models/collection/collection-request';
import {catchError, finalize, switchMap, take, takeUntil} from 'rxjs/operators';
import {SnackBarService} from '../../shared/services/snackBar/snack-bar.service';
import {ReviewDialogData} from '../../shared/models/review/reviewDialogData';
import {CollectionResponse} from '../../shared/models/collection/collection-response';
import {SpoilerCreationConfig} from '../../user/timeline/spoilers/spoiler-creation/spoiler-creation.component';
import {CollectionStatusType} from '../../shared/enums/collection-status-type';
import {ShareableStringGeneratorService} from '../../shared/services/utils/shareable-string-generator.service';
import {BanguminSpoilerService} from '../../shared/services/bangumin/bangumin-spoiler.service';
import {SpoilerExisted} from '../../shared/models/spoiler/spoiler-existed';
import {AuthenticationService} from '../../shared/services/auth.service';

/** Error when invalid control is dirty, touched, or submitted. */
export class InstantStateMatcher implements ErrorStateMatcher {
  isErrorState(control: FormControl | null, form: FormGroupDirective | NgForm | null): boolean {
    const isSubmitted = form && form.submitted;
    return (control && control.invalid && (control.dirty || control.touched || isSubmitted));
  }
}

export interface ReviewSchema {
  rating: number;
  tag: string;
  tagsArray: any[];
  collectionStatus: CollectionStatusType;
  comment: string;
  privacy: boolean;
  spoiler: boolean;
}

@Component({
  selector: 'app-review-dialog',
  templateUrl: './review-dialog.component.html',
  styleUrls: ['./review-dialog.component.scss']
})
export class ReviewDialogComponent implements OnInit, OnDestroy {

  commentMaxLength: number;
  subjectType: string;
  duringSubmit = false;
  collectionResponse: CollectionResponse;
  ratingForm: FormGroup;
  separatorKeysCodes = [ENTER, COMMA, SPACE];
  matcher = new InstantStateMatcher();


  readonly tagsMaxNumber: number;

  private ngUnsubscribe: Subject<void> = new Subject<void>();

  constructor(
    private authenticationService: AuthenticationService,
    private banguminSpoilerService: BanguminSpoilerService,
    private bangumiCollectionService: BangumiCollectionService,
    @Inject(MAT_DIALOG_DATA) public data: ReviewDialogData,
    public dialogRef: MatDialogRef<SingleSubjectComponent>,
    private formBuilder: FormBuilder,
    private shareableStringGeneratorService: ShareableStringGeneratorService,
    private snackBarService: SnackBarService) {

    this.commentMaxLength = data.enableSpoilerFlag ? SpoilerCreationConfig.MAX_SPOILER_TEXT_LENGTH : environment.commentMaxLength;
    this.tagsMaxNumber = environment.tagsMaxNumber;
    this.subjectType = SubjectType[data.subject.type];
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
    this.bangumiCollectionService.getSubjectCollectionStatus(this.data.subject.id).subscribe(collectionResponse => {
      this.collectionResponse = collectionResponse;
      this.initializeRatingForm(collectionResponse);
    });
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
        'spoiler': this.data.enableSpoilerFlag,
      }
    );
    this.onSpoilerFagValueChanges();
  }

  onSubmit() {
    this.duringSubmit = true;
    const ratingModel: ReviewSchema = this.ratingForm.value;
    // if spoiler flag has been enabled and comment is not empty and comment contains new line

    if (ratingModel.spoiler && ratingModel.comment && ratingModel.comment.indexOf('\n') !== -1) {
      const spoilerTextChunks = ShareableStringGeneratorService.convertRawTextToSpoilerTextChunk(ratingModel.comment || '');
      const newSpoiler = {
        spoilerText: spoilerTextChunks,
        relatedSubjects: [this.data.subject],
        relatedReviewSubjectId: this.data.subject.id
      };
      this.banguminSpoilerService.postNewSpoiler(newSpoiler)
        .pipe(
          switchMap((spoilerExisted: SpoilerExisted) => {
            const spoilerLink = `${environment.FRONTEND_URL}/user/${spoilerExisted.userId}/timeline/spoilers/${spoilerExisted.spoilerId}`;
            return this.shareableStringGeneratorService.generateCommentForBangumiSubjectReview(spoilerLink, spoilerTextChunks);
          }),
          switchMap((maskedComment: string) => this.postReview(Object.assign(ratingModel, {comment: maskedComment}))),
        )
        .subscribe(res => {
          this.dialogRef.close(res);
        });
    } else {
      this.postReview(ratingModel)
        .subscribe(res => {
          this.dialogRef.close(res);
        });
    }


  }

  postReview(reviewData: ReviewSchema) {
    const collectionRequest: CollectionRequest = new CollectionRequest(
      reviewData.collectionStatus, reviewData.comment, reviewData.tagsArray, reviewData.rating, reviewData.privacy === false ? 0 : 1);

    return this.bangumiCollectionService.upsertSubjectCollectionStatus(this.data.subject.id, collectionRequest).pipe(
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
    );
  }

  onCancelSubmit() {

  }

  onSpoilerFagValueChanges() {
    this.ratingForm.controls['spoiler'].valueChanges
      .pipe(
        takeUntil(this.ngUnsubscribe),
      )
      .subscribe((enableSpoilerFlag) => {
        this.commentMaxLength = enableSpoilerFlag ? SpoilerCreationConfig.MAX_SPOILER_TEXT_LENGTH : environment.commentMaxLength;
        this.ratingForm.controls['comment'].setValidators(Validators.maxLength(this.commentMaxLength));
        this.ratingForm.controls['comment'].updateValueAndValidity();
      });
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

  hasSpoiler() {
    return this.ratingForm.get('spoiler').value;
  }


}
