import {Component, OnDestroy, OnInit} from '@angular/core';
import {environment} from '../../../environments/environment';
import {MatDialog, MatSnackBar} from '@angular/material';
import {BangumiAuthWaitDialogComponent} from './bangumi-auth-wait-dialog/bangumi-auth-wait-dialog.component';
import {TranslateService} from '@ngx-translate/core';
import {AuthenticationService} from '../../shared/services/auth.service';
import {catchError, finalize, switchMap, takeUntil} from 'rxjs/operators';
import {Subject, throwError} from 'rxjs/index';
import {Router} from '@angular/router';

@Component({
  selector: 'app-login-bangumi',
  templateUrl: './login-bangumi.component.html',
  styleUrls: ['./login-bangumi.component.scss']
})
export class LoginBangumiComponent implements OnInit, OnDestroy {

  receiveMessageHandler;
  bangumiAuthWaitDialog;
  openedBangumiPopup;
  private ngUnsubscribe: Subject<void> = new Subject<void>();

  constructor(public dialog: MatDialog,
              public snackBar: MatSnackBar,
              private translateService: TranslateService,
              private router: Router,
              private authenticationService: AuthenticationService) {
  }

  redirectToBangumi() {
    this.openedBangumiPopup = window.open(`${environment.BACKEND_OAUTH_URL}/bangumi`);
    this.bangumiAuthWaitDialog = this.dialog.open(BangumiAuthWaitDialogComponent,
      {
        data: {
          receiveMessageHandler: this.receiveMessageHandler
        }
      });
  }
  ngOnInit() {
    this.receiveMessageHandler = this.receiveMessage.bind(this);
    if (window.addEventListener) {
      window.addEventListener('message', this.receiveMessageHandler, false);
    } else {
      (<any>window).attachEvent('onmessage', this.receiveMessageHandler);
    }

  }

  ngOnDestroy(): void {
    // unsubscribe, we can also first() in subscription
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }


  receiveMessage: any = (event: any) =>  {
    if (event && event.data && event.data.type === 'bangumiCallBack') {
      if (this.bangumiAuthWaitDialog) {
        this.bangumiAuthWaitDialog.close();
      }
      if (this.openedBangumiPopup) {
        this.openedBangumiPopup.close();
      }

      const bangumiCallBackData = event.data;
      let loginResultTranslationLabel: string;
      if (bangumiCallBackData.success === true) {
        this.authenticationService.verifyAndSetBangumiToken(bangumiCallBackData.accessToken, bangumiCallBackData.refreshToken)
          .pipe(
            takeUntil(this.ngUnsubscribe),
            switchMap(
              res => {
                loginResultTranslationLabel = 'login.loginSuccess';
                return this.translateService.get(loginResultTranslationLabel);
              }
            ),
            catchError(error => {
              loginResultTranslationLabel = 'login.loginFailure';
              return throwError(error);
            }),
            finalize(() => {
              this.translateService.get(loginResultTranslationLabel).subscribe(res => {
                this.snackBar.open(res, '', {
                  duration: 3000
                });
              });
              this.router.navigate(['/progress']);
            })
          )
          .subscribe( res => {
        });
      } else {
        loginResultTranslationLabel = 'login.loginFailure';
        this.translateService.get(loginResultTranslationLabel).subscribe(res => {
          this.snackBar.open(res, '', {
            duration: 3000
          });
        });
      }
    }
  }

}
