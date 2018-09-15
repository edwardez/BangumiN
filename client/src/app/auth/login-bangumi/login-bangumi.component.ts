import {Component, OnDestroy, OnInit} from '@angular/core';
import {environment} from '../../../environments/environment';
import {MatDialog, MatSnackBar} from '@angular/material';
import {BangumiAuthWaitDialogComponent} from './bangumi-auth-wait-dialog/bangumi-auth-wait-dialog.component';
import {TranslateService} from '@ngx-translate/core';
import {AuthenticationService} from '../../shared/services/auth.service';
import {catchError, finalize, switchMap, takeUntil} from 'rxjs/operators';
import {Subject, throwError} from 'rxjs';
import {Router} from '@angular/router';
import {StorageService} from '../../shared/services/storage.service';

@Component({
  selector: 'app-login-bangumi',
  templateUrl: './login-bangumi.component.html',
  styleUrls: ['./login-bangumi.component.scss']
})
export class LoginBangumiComponent implements OnInit, OnDestroy {

  receiveMessageHandler;
  bangumiAuthWaitDialog;
  openedBangumiPopup;
  disableLoginButton = false;
  private ngUnsubscribe: Subject<void> = new Subject<void>();

  receiveMessage: any = (event: any) => {
    if (event && event.data && event.data.type === 'bangumiCallBack') {
      if (this.bangumiAuthWaitDialog) {
        this.bangumiAuthWaitDialog.close();
      }
      if (this.openedBangumiPopup) {
        this.openedBangumiPopup.close();
      }
      this.removePostMessageListener();

      const bangumiCallBackData = event.data;
      let loginResultTranslationLabel: string;
      if (bangumiCallBackData['result'] === 'success') {
        this.authenticationService.verifyAndSetBangumiActivationInfo(bangumiCallBackData['userInfo'])
          .pipe(
            switchMap(
              res => {
                loginResultTranslationLabel = 'login.loginSuccess';
                this.router.navigate(['/progress']);
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
            }),
            takeUntil(this.ngUnsubscribe),
          )
          .subscribe(res => {
          });
      } else {
        loginResultTranslationLabel = 'login.loginFailure';
        this.translateService.get(loginResultTranslationLabel).subscribe(res => {
          this.snackBar.open(res, '', {
            duration: 10000
          });
        });
      }
    }
  };

  constructor(private authenticationService: AuthenticationService,
              public dialog: MatDialog,
              private router: Router,
              public snackBar: MatSnackBar,
              private storageService: StorageService,
              private translateService: TranslateService,
  ) {
    // clear storage
    this.storageService.clear();
  }

  ngOnInit() {
    this.receiveMessageHandler = this.receiveMessage.bind(this);
  }

  ngOnDestroy(): void {
    // unsubscribe, we can also first() in subscription
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

  redirectToBangumi() {
    window.addEventListener('message', this.receiveMessageHandler, false);
    this.openedBangumiPopup = window.open(`${environment.BACKEND_OAUTH_URL}/bangumi`);
    this.bangumiAuthWaitDialog = this.dialog.open(BangumiAuthWaitDialogComponent,
      {
        data: {
          receiveMessageHandler: this.receiveMessageHandler
        }
      });
    this.bangumiAuthWaitDialog.afterOpen().subscribe(
      res => {
        this.disableLoginButton = true;
      }
    );
    this.bangumiAuthWaitDialog.afterClosed().subscribe(res => {
      this.disableLoginButton = false;
    });
  }

  removePostMessageListener() {
    window.removeEventListener('message', this.receiveMessageHandler, false);
  }

}
