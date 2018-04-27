import { Component, OnInit } from '@angular/core';
import {ActivatedRoute} from '@angular/router';
import {BangumiSubjectService} from '../../shared/services/bangumi/bangumi-subject.service';

@Component({
  selector: 'app-single-subject',
  templateUrl: './single-subject.component.html',
  styleUrls: ['./single-subject.component.scss']
})
export class SingleSubjectComponent implements OnInit {

  constructor(private route: ActivatedRoute,
              private bangumiSubjectService: BangumiSubjectService
              ) { }

  ngOnInit() {

  }

}
