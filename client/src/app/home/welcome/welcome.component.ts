import {Component, OnInit} from '@angular/core';
import {TitleService} from '../../shared/services/page/title.service';
import {AuthenticationService} from '../../shared/services/auth.service';
import {BangumiUser} from '../../shared/models/BangumiUser';
import {filter, take} from 'rxjs/operators';

@Component({
  selector: 'app-welcome',
  templateUrl: './welcome.component.html',
  styleUrls: ['./welcome.component.scss']
})
export class WelcomeComponent implements OnInit {

  bangumiUser: BangumiUser;

  constructor(
    private authenticationService: AuthenticationService,
    private titleService: TitleService,
  ) {
  }

  ngOnInit() {
    this.authenticationService.userSubject
      .pipe(
        filter(bangumiUser => !!bangumiUser),
        take(1),
      )
      .subscribe(bangumiUser => {
        this.bangumiUser = bangumiUser;
      });

    this.titleService.setTitleByTranslationLabel('welcome.name');
  }

}
