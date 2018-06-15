import {throwError as observableThrowError, Observable, Subject, BehaviorSubject, of} from 'rxjs';
// this file is from https://github.com/serhiisol/ngx-auth-example with modifications
import {Injectable} from '@angular/core';
import {HttpClient, HttpErrorResponse, HttpHeaders} from '@angular/common/http';
import {StorageService} from './storage.service';
import {JwtHelperService} from '@auth0/angular-jwt';


import {environment} from '../../../environments/environment';
import {map, catchError, tap, switchMap, mergeMap} from 'rxjs/operators';
import {BangumiUser} from '../models/BangumiUser';
import {forkJoin} from 'rxjs/internal/observable/forkJoin';
import {BangumiRefreshTokenResponse} from '../models/common/bangumi-refresh-token-response';
import {MatSnackBar} from '@angular/material';
import {TranslateService} from '@ngx-translate/core';


interface AccessData {
  accessToken: string;
  refreshToken: string;
}

interface BangumiUserStatus {
  access_token: string;
  client_id: string;
  user_id: number;
  expires: number;
  scope: null;
}

@Injectable({
  providedIn: 'root'
})
export class AuthenticationService {

  userSubject: Subject<BangumiUser> = new BehaviorSubject<BangumiUser>(null);
  BANGUMI_API_URL = environment.BANGUMI_API_URL;

  constructor(private http: HttpClient,
              private storageService: StorageService,
              private translateService: TranslateService,
              private snackBar: MatSnackBar) {
  }

  /**
   * whether expiration deadline has passed, a millisecond epoch time should be passed in
   * @param {number} expirationTime
   * @returns {boolean}
   */
  private isTokenValid(expirationTime: number): Observable<boolean> {
    if (expirationTime === null || expirationTime === 0) {
      return of(false);
    }

    return of((expirationTime > Date.now() / 1000));
  }

  /**
   * Check, if user already authenticated.
   * Check whether
   * 1. token exists
   * 2. if token exists, whether it is expired and return
   true or false
   * @description Should return Observable with true or false values
   * @returns Observable<boolean>
   * @memberOf AuthenticationService
   */
  public isAuthenticated(): Observable<boolean> {
    const isAuthenticated = forkJoin(
      this.storageService
        .getAccessToken()
        .pipe(
          map(accessToken => {
            return accessToken != null;
          })),
      this.storageService
        .getBangumiAccessTokenExpirationTime()
        .pipe(
          switchMap(expirationTime => {
            return this.isTokenValid(expirationTime);
          })
        )
    );

    return isAuthenticated.pipe(
      map(resultArray => {
        return resultArray.reduce((a, b) => a && b);
      })
    );


  }

  /**
   * Get access token
   * @description Should return access token in Observable from e.g.
   * localStorage
   * @returns {Observable<string>}
   */
  public getAccessToken(): Observable<string> {
    return this.storageService.getAccessToken();
  }

  /**
   * Function, that should perform refresh token verifyTokenRequest
   * @description Should be successfully completed so interceptor
   * can execute pending requests or retry original one
   * @returns {Observable<any>}
   */
  public refreshBangumiOauthToken(): Observable<BangumiRefreshTokenResponse> {
    const currentTime = Math.floor(Date.now() / 1000);

    const options = {withCredentials: true};
    return this.storageService
      .getRefreshToken()
      .pipe(
        switchMap((refreshToken: string) => {
          return this.http.post(`${environment.BACKEND_OAUTH_URL}/bangumi/refresh`,
            {
              refreshToken: refreshToken,
              clientId: environment.BANGUMI_APP_ID,
              grantType: 'refresh_token',
              redirectUrl: `${environment.BACKEND_OAUTH_URL}/bangumi/callback`,
              userId: JSON.parse(localStorage.getItem('bangumiUser')).user_id
            },
            options);
        }),
        map( res => new BangumiRefreshTokenResponse().deserialize(res)),
        tap(
          res => {
            if (res.accessToken !== undefined && res.refreshToken !== undefined) {
              this.storageService.setAccessToken(res.accessToken);
              this.storageService.setRefreshToken(res.refreshToken);
              this.storageService.setBangumiAccessTokenExpirationTime((currentTime + res.expiresIn).toString());
            }
          }
        ),
        catchError(
          (err) => {
            this.logoutWithMessage('error.unauthorized');
            return observableThrowError(err);
          }
        )
      );
  }

  /**
   * Function, checks response of failed request to determine,
   * whether token be refreshed or not.
   * @description Essentialy checks status
   * @param {Response} response
   * @returns {boolean}
   */
  public refreshShouldHappen(response: HttpErrorResponse): boolean {
    return response.status === 401;
  }

  /**
   * Verify that outgoing request is refresh-token,
   * so interceptor won't intercept this request
   * @param {string} url
   * @returns {boolean}
   */
  public verifyTokenRequest(url: string): boolean {
    return url.endsWith('/refresh');
  }

  /**
   * EXTRA AUTH METHODS
   */

  public login(): Observable<any> {
    return this.http.post(`http://localhost:3000/login`, {})
      .pipe(
        tap(
          (tokens: AccessData) => this.saveAccessData(tokens)
        )
      );
  }

  /**
   * Logout
   */
  public logout(): void {
    this.storageService.clear();
    location.reload(true);
  }


  /**
   *logout with a snackbar message
   * @param {string} messageLabel a message label or a message string, first it will be treated as a message label, if such
   * label cannot be found in translation file, then the messageLabel itself will be used
   */
  public logoutWithMessage(messageLabel: string): void {
    const snackBarDuration = 3000;
    this.translateService.get(messageLabel).subscribe(res => {
      const messageSnackBar = this.snackBar.open(res, '', {
        duration: snackBarDuration
      });
      setTimeout(() => {
        this.logout();
      }, snackBarDuration);
  });
  }


  /**
   * Save access data in the storage
   *
   * @private
   * @param {AccessData} data
   */
  private saveAccessData({accessToken, refreshToken}: AccessData) {
    this.storageService
      .setAccessToken(accessToken)
      .setRefreshToken(refreshToken);
  }


  public verifyAndSetBangumiToken(accessToken: string, refreshToken: string): Observable<any> {
    const collectionRequestBody = new URLSearchParams();
    collectionRequestBody.set('access_token', accessToken);

    const headers = new HttpHeaders().set('Content-Type', 'application/x-www-form-urlencoded');

    return this.http.post(
      `${environment.BANGUMI_OAUTH_URL}/token_status`,
      collectionRequestBody.toString(), {headers: headers})
      .pipe(
        tap(authInfo => {
          if (authInfo['access_token'] === undefined
            || authInfo['client_id'] !== environment.BANGUMI_APP_ID) {
            throw Error('Invalid access token');
          }
        }),
        switchMap(authInfo => {
            this.storageService.setBangumiAccessTokenExpirationTime(authInfo['expires']);
            return this.http.get(`${this.BANGUMI_API_URL}/user/${authInfo['user_id']}`);
          }
        ),
        tap(bangumiUserInfo => {
          // save access token and refresh token to local storage
          const bangumiUser: BangumiUser = new BangumiUser().deserialize(bangumiUserInfo);
          this.storageService.setBangumiUser(bangumiUser);
          this.storageService.setAccessToken(accessToken);
          this.storageService.setRefreshToken(refreshToken);
          this.userSubject.next(bangumiUser);
        }),
        catchError(
          (err) => {
            return observableThrowError(err);
          }
        )
      );

  }

}
