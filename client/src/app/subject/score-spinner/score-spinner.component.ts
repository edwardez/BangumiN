import {Component, Input, OnInit} from '@angular/core';

@Component({
  selector: 'app-score-spinner',
  templateUrl: './score-spinner.component.html',
  styleUrls: ['./score-spinner.component.scss']
})
export class ScoreSpinnerComponent implements OnInit {

  @Input()
  score: number;

  constructor() {
  }

  ngOnInit() {
  }

}
