import { Component, OnInit } from '@angular/core';
import {ReviewDialogInitialState} from '../single-subject/single-subject.component';

@Component({
  selector: 'app-subject-spoiler-creation',
  templateUrl: './subject-spoiler-creation.component.html',
  styleUrls: ['./subject-spoiler-creation.component.scss']
})
export class SubjectSpoilerCreationComponent implements OnInit {

  constructor() { }

  ngOnInit() {
  }

  setReviewDialogInitialState() {
    return ReviewDialogInitialState.OpenAndEnableSpoilerFlag;
  }

}
