import { Component, OnInit } from '@angular/core';
import {ActivatedRoute} from '@angular/router';
import {BangumiSubjectService} from '../../shared/services/bangumi/bangumi-subject.service';
import {filter, switchMap} from 'rxjs/operators';
import {SubjectSmall} from '../../shared/models/subject/subject-small';
import {SubjectLarge} from '../../shared/models/subject/subject-large';

@Component({
  selector: 'app-single-subject',
  templateUrl: './single-subject.component.html',
  styleUrls: ['./single-subject.component.scss']
})
export class SingleSubjectComponent implements OnInit {

  subject: SubjectLarge;

  constructor(private route: ActivatedRoute,
              private bangumiSubjectService: BangumiSubjectService
              ) { }

  ngOnInit() {
    this.route
      .params
      .pipe(
        filter(params => params['id'] !== undefined),
        switchMap(params => {
          return this.bangumiSubjectService.getSubject( params['id'], 'large');
        }
      ))
      .subscribe( res => {
        this.subject = res;
      });
  }

}
