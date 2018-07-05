import {Component, OnInit} from '@angular/core';
import {ActivatedRoute} from '@angular/router';
import {BangumiSubjectService} from '../../shared/services/bangumi/bangumi-subject.service';
import {filter, switchMap} from 'rxjs/operators';
import {SubjectLarge} from '../../shared/models/subject/subject-large';
import {forkJoin} from 'rxjs';
import {BangumiCollectionService} from '../../shared/services/bangumi/bangumi-collection.service';
import {CollectionResponse} from '../../shared/models/collection/collection-response';
import {TitleService} from '../../shared/services/page/title.service';
import {ReviewDialogData} from '../../shared/models/review/reviewDialogData';
import {ReviewDialogService} from '../../shared/services/dialog/review-dialog.service';
import {MonoBase} from '../../shared/models/mono/mono-base';


@Component({
  selector: 'app-single-subject',
  templateUrl: './single-subject.component.html',
  styleUrls: ['./single-subject.component.scss']
})
export class SingleSubjectComponent implements OnInit {

  subject: SubjectLarge;
  collectionResponse: CollectionResponse;
  currentRating = 0;

  constructor(private route: ActivatedRoute,
              private bangumiSubjectService: BangumiSubjectService,
              private bangumiCollectionService: BangumiCollectionService,
              private titleService: TitleService,
              private reviewDialogService: ReviewDialogService
  ) {
  }

  ngOnInit() {
    window.scrollTo(0, 0); // scroll to the top
    this.route
      .params
      .pipe(
        filter(params => params['id'] !== undefined),
        switchMap(params => {
            return forkJoin(
              this.bangumiSubjectService.getSubject(params['id'], 'large'),
              this.bangumiCollectionService.getSubjectCollectionStatus(params['id']));
          },
        ))
      .subscribe(res => {

        this.subject = res[0];
        console.log(this.subject);
        this.titleService.title = this.subject.name;
        this.collectionResponse = res[1];
        this.currentRating = this.collectionResponse.rating;
      });


  }

  onRatingChanged(rating) {
    this.currentRating = rating;
  }

  /*
  Note on autoFocus: It is an accessibility feature.
  The dialog automatically focuses the first focus-able element.
  This can be set as a configurable option if needed
  */
  openDialog(): void {

    // construct review dialog data
    const reviewDialogData: ReviewDialogData = {
      subjectId: this.subject.id,
      rating: this.currentRating,
      tags: this.collectionResponse.tags,
      statusType: this.collectionResponse.status.type,
      comment: this.collectionResponse.comment,
      privacy: this.collectionResponse.privacy,
      type: this.subject.type
    };


    // open the dialog
    const dialogRefObservable = this.reviewDialogService.openReviewDialog(reviewDialogData);

    dialogRefObservable
      .pipe(
        switchMap(dialogRef => dialogRef.afterClosed()),
        filter(result => result !== undefined && result['rating'] !== undefined),
      )
      .subscribe(result => {
        this.currentRating = result['rating'];
        this.collectionResponse = new CollectionResponse().deserialize(result);
      });


  }

  generateActorsList(actorsInfo: MonoBase[]): string {
    const actors = actorsInfo.reduce((accumulatedValue, currentValue) => {
      accumulatedValue.push(currentValue.name);
      return accumulatedValue;
    }, []);

    return actors.length >= 1 ? 'CV: ' + actors.join(' / ') : '';
  }


}
