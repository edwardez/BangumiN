import {Component, Input, OnInit} from '@angular/core';
import {SubjectRating} from '../../shared/models/subject/subject-rating';

@Component({
  selector: 'app-score-spinner',
  templateUrl: './score-spinner.component.html',
  styleUrls: ['./score-spinner.component.scss']
})
export class ScoreSpinnerComponent implements OnInit {

  @Input()
  rating: SubjectRating;

  constructor() {
  }

  ngOnInit() {
  }

}
