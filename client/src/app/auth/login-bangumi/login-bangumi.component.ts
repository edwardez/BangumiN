import {Component, OnInit} from '@angular/core';
import {environment} from '../../../environments/environment';
import {MatDialog, MatSnackBar} from '@angular/material';
import {BangumiAuthWaitDialogComponent} from './bangumi-auth-wait-dialog/bangumi-auth-wait-dialog.component';
import {TranslateService} from '@ngx-translate/core';
import {StorageService} from '../../shared/services/storage.service';

@Component({
  selector: 'app-login-bangumi',
  templateUrl: './login-bangumi.component.html',
  styleUrls: ['./login-bangumi.component.scss']
})
export class LoginBangumiComponent implements OnInit {

  receiveMessageHandler;
  bangumiAuthWaitDialog;

  constructor(public dialog: MatDialog,
              public snackBar: MatSnackBar,
              private translateService: TranslateService,
              private storageService: StorageService) {
  }

  redirectToBangumi() {
    window.open(`${environment.BACKEND_OAUTH_REDIRECT_URL}/bangumi`);
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

  receiveMessage: any = (event: any) =>  {
    if (event && event.data && event.data.type === 'bangumiCallBack') {
      if (this.bangumiAuthWaitDialog) {
        this.bangumiAuthWaitDialog.close();
      }
      const bangumiCallBackData = event.data;
      let loginResultTranslationLabel: string;
      if (bangumiCallBackData.success === true) {
        loginResultTranslationLabel = 'login.loginSuccess';
      } else {
        loginResultTranslationLabel = 'login.loginFailure';
      }

      this.translateService.get(loginResultTranslationLabel).subscribe( (res: string) => {
        this.snackBar.open(res);
      });
    }
  }

}
