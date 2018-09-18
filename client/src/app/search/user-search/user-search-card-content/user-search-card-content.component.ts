import {Component, Input, OnInit} from '@angular/core';
import {BangumiUser} from '../../../shared/models/BangumiUser';
import {BangumiUserRole} from '../../../shared/enums/bangumi-user-role.enum';

@Component({
  selector: 'app-user-search-card-content',
  templateUrl: './user-search-card-content.component.html',
  styleUrls: ['./user-search-card-content.component.scss']
})
export class UserSearchCardContentComponent implements OnInit {

  @Input()
  user: BangumiUser;

  constructor() {
  }

  get BangumiUserRole() {
    return BangumiUserRole;
  }

  ngOnInit() {
  }

}
