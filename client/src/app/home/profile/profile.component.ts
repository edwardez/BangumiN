import {Component, OnInit} from '@angular/core';
import {_} from '../../shared/utils/translation-marker';
import {SubjectType} from '../../shared/enums/subject-type.enum';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss']
})
export class ProfileComponent implements OnInit {

  validSubjectTypeArray: string[] = [];

  static get subjectType() {return SubjectType; }

  constructor() {

    for (const item in SubjectType) {
      if (isNaN(Number(item)) && item !== 'all') {
        this.validSubjectTypeArray.push(item);
      }
    }
  }

  ngOnInit() {
  }

}
