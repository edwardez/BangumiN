import { Component, OnInit } from '@angular/core';
import {ActivatedRoute} from '@angular/router';
import {BangumiSubjectService} from '../../shared/services/bangumi/bangumi-subject.service';
import {filter, switchMap} from 'rxjs/operators';
import {SubjectSmall} from '../../shared/models/subject/subject-small';
import {SubjectLarge} from '../../shared/models/subject/subject-large';
import {MatDialog} from '@angular/material';
import {ReviewDialogComponent} from './review-dialog/review-dialog.component';
import {forkJoin} from 'rxjs/observable/forkJoin';
import {BangumiCollectionService} from '../../shared/services/bangumi/bangumi-collection.service';

@Component({
  selector: 'app-single-subject',
  templateUrl: './single-subject.component.html',
  styleUrls: ['./single-subject.component.scss']
})
export class SingleSubjectComponent implements OnInit {

  subject: SubjectLarge;
  currentRating = 0;

  constructor(private route: ActivatedRoute,
              public dialog: MatDialog,
              private bangumiSubjectService: BangumiSubjectService,
              private bangumiCollectionService: BangumiCollectionService
              ) { }

  ngOnInit() {
    this.route
      .params
      .pipe(
        filter(params => params['id'] !== undefined),
        switchMap(params => {
          return forkJoin(
            this.bangumiSubjectService.getSubject( params['id'], 'large'),
            this.bangumiCollectionService.getSubjectCollectionStatus( params['id']));
        }
      ))
      .subscribe( res => {
        this.subject = res[0];
        this.currentRating = res[1] && res[1].rating ? res[1].rating : 0; // todo: parse result
      });
  }

  onRatingChanged(rating) {
    this.currentRating = rating;
  }


  openDialog(): void {
    const dialogRef = this.dialog.open(ReviewDialogComponent, {
      data: {}
    });
  }

}
