import {Component, ContentChildren, OnInit} from '@angular/core';
import {SidenavService} from '../../shared/services/sidenav.service';
import {AuthenticationService} from '../../shared/services/auth.service';
import 'rxjs/add/operator/filter';

@Component({
  selector: 'app-nav',
  templateUrl: './nav.component.html',
  styleUrls: ['./nav.component.scss']
})
export class NavComponent implements OnInit {
  imgSrc = 'https://lain.bgm.tv/pic/user/l/icon.jpg';

  constructor(private sidenavService: SidenavService,
              private authService: AuthenticationService) { }

  ngOnInit() {

    this.authService.userSubject.filter(user => !!user).subscribe( user => {
      this.imgSrc = user.avatar;

    });
  }


  toggleSidenav() {
    this.sidenavService
      .toggle()
      .then(() => { });

  }

}
