// this file is from https://github.com/serhiisol/ngx-auth-example/blob/master/src/app/shared/authentication/authentication.service.ts
import {Injectable} from '@angular/core';
import {HttpClient, HttpErrorResponse, HttpHeaders} from '@angular/common/http';
import {Observable} from 'rxjs/Observable';
import {TokenStorage} from './token-storage.service';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/do';
import {environment} from '../../../environments/environment';
import {map, catchError, tap} from 'rxjs/operators';
import 'rxjs/add/observable/throw';



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

  constructor(private http: HttpClient,
              private tokenStorage: TokenStorage) {
  }

  /**
   * Check, if user already authorized.
   * @description Should return Observable with true or false values
   * @returns {Observable<boolean>}
   * @memberOf AuthService
   */
  public isAuthorized(): Observable<boolean> {
    return this.tokenStorage
      .getAccessToken()
      .map(token => !!token);
  }

  /**
   * Get access token
   * @description Should return access token in Observable from e.g.
   * localStorage
   * @returns {Observable<string>}
   */
  public getAccessToken(): Observable<string> {
    return this.tokenStorage.getAccessToken();
  }

  /**
   * Function, that should perform refresh token verifyTokenRequest
   * @description Should be successfully completed so interceptor
   * can execute pending requests or retry original one
   * @returns {Observable<any>}
   */
  public refreshToken(): Observable<AccessData> {
    return this.tokenStorage
      .getRefreshToken()
      .switchMap((refreshToken: string) => {
        return this.http.post(`http://localhost:3000/refresh`, {refreshToken});
      })
      .do(this.saveAccessData.bind(this))
      .catch((err) => {
        this.logout();

        return Observable.throw(err);
      });
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
      .pipe()
      .do((tokens: AccessData) => this.saveAccessData(tokens));
  }

  /**
   * Logout
   */
  public logout(): void {
    this.tokenStorage.clear();
    location.reload(true);
  }

  /**
   * Save access data in the storage
   *
   * @private
   * @param {AccessData} data
   */
  private saveAccessData({accessToken, refreshToken}: AccessData) {
    this.tokenStorage
      .setAccessToken(accessToken)
      .setRefreshToken(refreshToken);
  }


  public verifyAccessToken(accessToken: string): Observable<BangumiUserStatus> {

    return this.http.post<BangumiUserStatus>(
      `${environment.BACKEND_AUTH_URL}/jwt/token`,
      {accessToken: accessToken},
      {observe: 'response' } )
      .pipe(
        tap( response => {
          // save access token to local storage
          // const token = x.headers.get('x-auth-token');
          const jwtToken = response.headers.get('Authorization');
          if (jwtToken && jwtToken.split(' ')[0] === 'Bearer') {
            this.tokenStorage.setJwtToken(jwtToken.split(' ')[1]);
          }
          this.tokenStorage.setAccessToken(accessToken);
        }),
      ).catch((err) => {
        return Observable.throw(err);
      });

  }

}
