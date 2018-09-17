import {Component, Input, OnInit} from '@angular/core';
import {BangumiUser} from '../../../shared/models/BangumiUser';

@Component({
  selector: 'app-user-search-single-result-card',
  templateUrl: './user-search-single-result-card.component.html',
  styleUrls: ['./user-search-single-result-card.component.scss']
})
export class UserSearchSingleResultCardComponent implements OnInit {

  @Input()
  user: BangumiUser;

  constructor() {
  }

  ngOnInit() {
  }

}
