import {Component, ContentChildren, OnInit} from '@angular/core';
import {SidenavService} from '../../shared/services/sidenav.service';
import {AuthenticationService} from '../../shared/services/auth.service';
import {first} from 'rxjs/operators';
import {StorageService} from '../../shared/services/storage.service';
import {BangumiUser} from '../../shared/models/BangumiUser';

@Component({
  selector: 'app-nav',
  templateUrl: './nav.component.html',
  styleUrls: ['./nav.component.scss']
})
export class NavComponent implements OnInit {
  bangumiUser: BangumiUser;
  imgSrc = 'https://lain.bgm.tv/pic/user/l/icon.jpg';

  constructor(private sidenavService: SidenavService,
              private storageService: StorageService,
              private authService: AuthenticationService) { }

  ngOnInit() {

    // we retrieve relevant user info here, we'll subscribe to first non-null userSubject
    // if user is logged in, then user info is stored in local storage, we'll send new value to userSubject
    // if user is not logged in, we'll wait for the first value
    // after thr first value, unsubscribe userSubject
    this.authService.userSubject
      .pipe(
        first(bangumiUser => !!bangumiUser)
      )
      .subscribe( bangumiUser => {
        this.imgSrc = bangumiUser.avatar;
      });

    this.storageService.getBangumiUser().pipe(
      first(bangumiUser => bangumiUser !== null),
    ).subscribe( bangumiUser => {
        this.authService.userSubject.next(bangumiUser);
    });

  }


  toggleSidenav() {
    this.sidenavService
      .toggle()
      .then(() => { });

  }

}
