import {Component, OnDestroy, OnInit} from '@angular/core';
import {environment} from '../../../environments/environment';
import {MatDialog, MatSnackBar} from '@angular/material';
import {TranslateService} from '@ngx-translate/core';
import {AuthenticationService} from '../../shared/services/auth.service';
import {Subject} from 'rxjs';
import {Router} from '@angular/router';
import {StorageService} from '../../shared/services/storage.service';

@Component({
  selector: 'app-login-bangumi',
  templateUrl: './login-bangumi.component.html',
  styleUrls: ['./login-bangumi.component.scss']
})
export class LoginBangumiComponent implements OnInit, OnDestroy {

  backendOauthUrl = `${environment.BACKEND_OAUTH_URL}/bangumi`;
  disableLoginButton = false;
  private ngUnsubscribe: Subject<void> = new Subject<void>();

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
  }

  ngOnDestroy(): void {
    // unsubscribe, we can also first() in subscription
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

}
