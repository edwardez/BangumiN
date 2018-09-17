import {Component, Input, OnInit} from '@angular/core';

@Component({
  selector: 'app-subject-search',
  templateUrl: './subject-search.component.html',
  styleUrls: ['./subject-search.component.scss']
})
export class SubjectSearchComponent implements OnInit {

  @Input()
  queryKeyword: string;

  constructor() {
  }

  ngOnInit() {
  }

}
