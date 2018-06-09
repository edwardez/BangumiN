import {Component, OnDestroy, OnInit} from '@angular/core';
import {ActivatedRoute, Router} from '@angular/router';
import {AuthenticationService} from '../../../shared/services/auth.service';
import {takeUntil} from 'rxjs/operators';
import {Subject} from 'rxjs';
import {CookieService} from 'ngx-cookie';
import {environment} from '../../../../environments/environment';

@Component({
  selector: 'app-activate-bangumi',
  templateUrl: './activate-bangumi.component.html',
  styleUrls: ['./activate-bangumi.component.scss']
})
export class ActivateBangumiComponent implements OnInit, OnDestroy {
  private ngUnsubscribe: Subject<void> = new Subject<void>();

  constructor(private route: ActivatedRoute,
              private router: Router,
              private authService: AuthenticationService,
              private cookieService: CookieService) {
  }

  ngOnInit() {
    const activationInfo = this.cookieService.getObject('activationInfo') || {};
    if (typeof activationInfo['access_token'] === 'string' && typeof activationInfo['refresh_token'] === 'string') {
      window.opener.postMessage(
        {
          'type': 'bangumiCallBack',
          'success': true,
          'accessToken': activationInfo['access_token'],
          'refreshToken': activationInfo['refresh_token']
        }, environment.FRONTEND_URL);

      this.cookieService.remove('activationInfo');
    } else {
      window.opener.postMessage(
        {
          'type': 'bangumiCallBack',
          'success': false,
        }, environment.FRONTEND_URL);
    }
  }

  ngOnDestroy(): void {
    // unsubscribe, we can also first() in subscription
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

}

