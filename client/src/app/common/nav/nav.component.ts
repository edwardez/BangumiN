import {Component, ContentChildren, OnInit} from '@angular/core';
import {SidenavService} from '../../shared/services/sidenav.service';
import {AuthenticationService} from '../../shared/services/auth.service';
import {filter, first, take, tap} from 'rxjs/operators';
import {StorageService} from '../../shared/services/storage.service';
import {BangumiUser} from '../../shared/models/BangumiUser';
import { concat } from 'rxjs/observable/concat';
import {BangumiUserService} from '../../shared/services/bangumi/bangumi-user.service';

@Component({
  selector: 'app-nav',
  templateUrl: './nav.component.html',
  styleUrls: ['./nav.component.scss']
})
export class NavComponent implements OnInit {
  bangumiUser: BangumiUser;

  constructor(private sidenavService: SidenavService,
              private storageService: StorageService,
              private authService: AuthenticationService,
              private bangumiUserService: BangumiUserService) {
    // initialize a dummy user
    this.bangumiUser = new BangumiUser().deserialize({
      id: '',
      avatar: {large: 'https://lain.bgm.tv/pic/user/l/icon.jpg',
        medium: 'https://lain.bgm.tv/pic/user/m/icon.jpg',
        small: 'https://lain.bgm.tv/pic/user/s/icon.jpg'},
      nickname: '',
      username: ''
    });
  }

  ngOnInit() {
    this.updateUserInfo();
  }

  /**
   ** we retrieve relevant user info here, we'll subscribe to first two user info service, and they must be non-null
   ** why two? because
   ** 1. the first value is from localStorage (to ensure speed)
   ** 2. the second value is from http service (slower, and user might change their avatar on computer A, after
   ** that they expect to see new avatar on computer B after refreshing)
   ** in more complicated cases, takeUntil should be used
   */

  updateUserInfo() {
    const userInfoServiceArray = [this.storageService.getBangumiUser(), this.bangumiUserService.getUserInfo()];


    concat.apply(this, userInfoServiceArray)
      .pipe(
        take(userInfoServiceArray.length),
        filter(bangumiUser => !!bangumiUser),
      )
      .subscribe( bangumiUser => {
        this.bangumiUser = bangumiUser;
      });
  }

  toggleSidenav() {
    this.sidenavService
      .toggle()
      .then(() => { });

  }

}
