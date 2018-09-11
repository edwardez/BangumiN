import {Component, OnDestroy, OnInit} from '@angular/core';
import {ActivatedRoute, Router} from '@angular/router';
import {AuthenticationService} from '../../../shared/services/auth.service';
import {Subject} from 'rxjs';
import {CookieService} from 'ngx-cookie';
import {environment} from '../../../../environments/environment';
import {tap} from 'rxjs/operators';

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

  static postFailureMessage() {
    window.opener.postMessage(
      {
        'type': 'bangumiCallBack',
        'result': 'failure',
      }, environment.FRONTEND_URL);
    window.close();
  }

  ngOnInit() {
    this.route
      .queryParams
      .pipe(
        tap(
          params => {
            if (params['type'] !== 'bangumi' || params['result'] !== 'success') {
              ActivateBangumiComponent.postFailureMessage();
            }
          }
        ),
      )
      .subscribe(res => {
        this.getBangumiActivationInfo();
      });

  }

  getBangumiActivationInfo() {
    const userInfo = this.cookieService.getObject('userInfo') || {bangumiProfile: {}, banguminSettings: {}};
    if (typeof userInfo['bangumiActivationInfo']['access_token'] === 'string' &&
      typeof userInfo['bangumiActivationInfo']['refresh_token'] === 'string') {
      window.opener.postMessage(
        {
          type: 'bangumiCallBack',
          result: 'success',
          userInfo: userInfo,
        }, environment.FRONTEND_URL);

      this.cookieService.remove('userInfo');
    } else {
      ActivateBangumiComponent.postFailureMessage();
    }
    window.close();
  }


  ngOnDestroy(): void {
    // unsubscribe, we can also first() in subscription
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

}

