
import {throwError as observableThrowError, Observable, Subject, BehaviorSubject} from 'rxjs';
// this file is from https://github.com/serhiisol/ngx-auth-example/blob/master/src/app/shared/authentication/authentication.service.ts
import {Injectable} from '@angular/core';
import {HttpClient, HttpErrorResponse, HttpHeaders} from '@angular/common/http';
import {StorageService} from './storage.service';
import { JwtHelperService } from '@auth0/angular-jwt';


import {environment} from '../../../environments/environment';
import {map, catchError, tap, switchMap} from 'rxjs/operators';
import {BangumiUser} from '../models/BangumiUser';



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



@Injectable()
export class AuthenticationService {

  userSubject: Subject<BangumiUser> = new BehaviorSubject<BangumiUser>(null);
  BANGUMI_API_URL = environment.BANGUMI_API_URL;

  constructor(private http: HttpClient,
              private storageService: StorageService,
              private jwtHelper: JwtHelperService) {
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

    return this.storageService.getJwtToken().pipe(
      map(jwtToken => {
        if (jwtToken == null) {
          return false;
        } else {
          return !this.jwtHelper.isTokenExpired(jwtToken);
        }
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
  public refreshToken(): Observable<any> {
    return this.storageService
      .getRefreshToken()
      .pipe(
        switchMap((refreshToken: string) => {
          return this.http.post(`http://localhost:3000/refresh`, {refreshToken});
        }),
        tap(
          this.saveAccessData.bind(this)
        ),
        catchError(
          (err) => {
            this.logout();
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


  public verifyAccessToken(accessToken: string): Observable<any> {

    return this.http.post(
      `${environment.BACKEND_AUTH_URL}/jwt/token`,
      {accessToken: accessToken},
      {observe: 'response' } )
      .pipe(
        switchMap( response => this.http.get(`${this.BANGUMI_API_URL}/user/${response['body']['user_id']}`), (outer, inner) => {
          return {'authDetails': outer, 'bangumiUserInfo': inner};
        }),
        tap( response => {
          const {authDetails, bangumiUserInfo} = response;
          // save access token to local storage
          const jwtToken = authDetails.headers.get('Authorization');
          if (jwtToken && jwtToken.split(' ')[0] === 'Bearer') {
            this.storageService.setJwtToken(jwtToken.split(' ')[1]);
          }
          this.storageService.setAccessToken(accessToken);
          const bangumiUser: BangumiUser = new BangumiUser().deserialize(bangumiUserInfo);
          this.userSubject.next(bangumiUser);
          this.storageService.setBangumiUser(bangumiUser);
        }),
        catchError(
          (err) => {
            return observableThrowError(err);
          }
        )
      );

  }

}
