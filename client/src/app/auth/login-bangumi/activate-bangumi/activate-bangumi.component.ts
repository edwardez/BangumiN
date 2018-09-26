import {Component, OnDestroy, OnInit} from '@angular/core';
import {ActivatedRoute, Router} from '@angular/router';
import {AuthenticationService, UserInfo} from '../../../shared/services/auth.service';
import {Subject, throwError} from 'rxjs';
import {CookieService} from 'ngx-cookie';
import {catchError, finalize, map, switchMap, take, takeUntil} from 'rxjs/operators';
import {MatSnackBar} from '@angular/material';
import {StorageService} from '../../../shared/services/storage.service';
import {TranslateService} from '@ngx-translate/core';
import {SnackBarService} from '../../../shared/services/snackBar/snack-bar.service';


enum QueryParamsType {
  ActivationUnsuccessful = 1,
  ActivationSuccessful = 2,
  IllegalParams = 3,
}


enum QueryParamsCheckResult {
  ProceedToActivationNextStep = 1,
  ActivationFailed = 2,
  RedirectAlreadyLoggedInUser = 3,
  RedirectIllegalAccessGuest = 4,
}

enum ActivationStage {
  InProgress = 1,
  Success = 2,
  Failure = 3,
}

interface ActivationCheckResult {
  isAuthenticated: boolean;
  queryParamsCheckResult: QueryParamsCheckResult;
  userInfo: UserInfo;
}

@Component({
  selector: 'app-activate-bangumi',
  templateUrl: './activate-bangumi.component.html',
  styleUrls: ['./activate-bangumi.component.scss']
})
export class ActivateBangumiComponent implements OnInit, OnDestroy {
  private ngUnsubscribe: Subject<void> = new Subject<void>();
  activationStage = ActivationStage.InProgress;

  constructor(private route: ActivatedRoute,
              private router: Router,
              private authenticationService: AuthenticationService,
              private cookieService: CookieService,
              public snackBar: MatSnackBar,
              private snackBarService: SnackBarService,
              private storageService: StorageService,
              private translateService: TranslateService,) {
  }

  get ActivationStage() {
    return ActivationStage;
  }

  static isValidActivationCookie(userInfo: UserInfo): boolean {
    return typeof userInfo['bangumiActivationInfo']['access_token'] === 'string' &&
      typeof userInfo['bangumiActivationInfo']['refresh_token'] === 'string';
  }

  static checkQueryParamsType(params: {}): QueryParamsType {
    if (params['type'] === 'bangumi') {
      if (params['result'] === 'failure') {
        return QueryParamsType.ActivationUnsuccessful;
      }
      if (params['result'] === 'success') {
        return QueryParamsType.ActivationSuccessful;
      }
    }

    return QueryParamsType.IllegalParams;
  }

  ngOnInit() {
    this.checkActivationInfo();
  }

  checkActivationInfo() {
    this.route
      .queryParams
      .pipe(
        switchMap(params => {
          const queryParamsType: QueryParamsType = ActivateBangumiComponent.checkQueryParamsType(params);
          return this.authenticationService.isAuthenticated()
            .pipe(
              take(1),
              map(isAuthenticated => {
                // get userInfo from cookie, then remove it in consideration of security
                const userInfo: UserInfo = (this.cookieService.getObject('userInfo') ||
                  {bangumiActivationInfo: {}, banguminSettings: {}}) as UserInfo;
                this.cookieService.remove('userInfo');
                let queryParamsCheckResult: QueryParamsCheckResult;
                if (isAuthenticated) {
                  if (ActivateBangumiComponent.isValidActivationCookie(userInfo)) {
                    if (queryParamsType === QueryParamsType.ActivationSuccessful) {
                      // if user is authenticated, and params shows ActivationSuccessful
                      queryParamsCheckResult = QueryParamsCheckResult.ProceedToActivationNextStep;
                    } else {
                      // if user is authenticated, and params shows activation is not successful
                      queryParamsCheckResult = QueryParamsCheckResult.ActivationFailed;
                    }
                  } else {
                    // if user is authenticated, and params doesn't match: this url is not redirected by the app it self, ignore the request
                    // and redirect user
                    queryParamsCheckResult = QueryParamsCheckResult.RedirectAlreadyLoggedInUser;
                  }

                } else {
                  // if user is not authenticated, set queryParamsCheckResult according to parameter type
                  switch (queryParamsType) {
                    case QueryParamsType.ActivationUnsuccessful:
                      queryParamsCheckResult = QueryParamsCheckResult.ActivationFailed;
                      break;
                    case QueryParamsType.ActivationSuccessful:
                      queryParamsCheckResult = QueryParamsCheckResult.ProceedToActivationNextStep;
                      break;
                    case QueryParamsType.IllegalParams:
                      queryParamsCheckResult = QueryParamsCheckResult.RedirectIllegalAccessGuest;
                      break;
                    default:
                      queryParamsCheckResult = QueryParamsCheckResult.ActivationFailed;
                      break;
                  }
                }
                return {isAuthenticated, queryParamsCheckResult, userInfo};
              })
            );
        })
      )
      .subscribe((activationCheckResult: ActivationCheckResult) => {
        switch (activationCheckResult.queryParamsCheckResult) {
          case QueryParamsCheckResult.ProceedToActivationNextStep:
            this.getBangumiActivationInfo(activationCheckResult);
            break;
          case QueryParamsCheckResult.RedirectAlreadyLoggedInUser:
            this.snackBarService.openSimpleSnackBar('login.alreadyLoggedIn', undefined,
              {duration: 3000}).subscribe();
            this.router.navigate(['/welcome']);
            break;
          case QueryParamsCheckResult.ActivationFailed:
            this.snackBarService.openSimpleSnackBar('login.loginFailure', undefined,
              {duration: 10000}).subscribe();
            this.router.navigate(['/login']);
            break;
          case QueryParamsCheckResult.RedirectIllegalAccessGuest:
            this.router.navigate(['/login']);
            break;
          default:
            // above should have handled all cases, if not, redirect user to welcome page and let app guard handles the rest
            this.router.navigate(['/welcome']);
            break;
        }
      });
  }


  ngOnDestroy(): void {
    // unsubscribe, we can also first() in subscription
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

  getBangumiActivationInfo(activationCheckResult: ActivationCheckResult) {
    let loginResultTranslationLabel = 'login.loginFailure';
    const isStandalone = window.matchMedia('(display-mode: standalone)').matches;
    this.authenticationService.verifyAndSetBangumiActivationInfo(activationCheckResult.userInfo)
      .pipe(
        switchMap(
          res => {
            this.activationStage = ActivationStage.Success;
            loginResultTranslationLabel = 'login.loginSuccess';
            this.router.navigate(['/welcome']);
            return this.translateService.get(loginResultTranslationLabel);
          }
        ),
        catchError(error => {
          this.activationStage = ActivationStage.Failure;
          loginResultTranslationLabel = 'login.loginFailure';
          return throwError(error);
        }),
        finalize(() => {
          this.translateService.get(loginResultTranslationLabel).subscribe(res => {
            this.snackBar.open(res, '', {
              duration: 2000
            });
          });
        }),
        takeUntil(this.ngUnsubscribe),
      )
      .subscribe(res => {
      });
  }

  closeWindow() {
    window.close();
  }

}

