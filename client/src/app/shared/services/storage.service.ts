// this file is from https://github.com/serhiisol/ngx-auth-example/blob/master/src/app/shared/authentication/token-storage.service.ts
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/observable/of';
import 'rxjs/add/operator/switchMap';
import 'rxjs/add/operator/catch';
import {BangumiUser} from '../models/BangumiUser';

@Injectable()
export class StorageService {

  /**
   * Get access token
   * @returns {Observable<string>}
   */
  public getAccessToken(): Observable<string> {
    const token: string = <string>localStorage.getItem('accessToken');
    return Observable.of(token);
  }

  /**
   * Get refresh token
   * @returns {Observable<string>}
   */
  public getRefreshToken(): Observable<string> {
    const token: string = <string>localStorage.getItem('refreshToken');
    return Observable.of(token);
  }

  /**
   * Get jwt token
   * @returns {Observable<string>}
   */
  public getJwtToken(): Observable<string> {
    const token: string = <string>localStorage.getItem('jwtToken');
    return Observable.of(token);
  }

  /**
   * Get bangumi user info
   * @returns {StorageService}
   */
  public getBangumiUser(): Observable<BangumiUser> {
    const bangumiUserInfo: string = localStorage.getItem('bangumiUser');
    let bangumiUser: BangumiUser;

    try {
      bangumiUser = new BangumiUser().deserialize(JSON.parse(bangumiUserInfo));
    } catch (err) {
      console.log('Failed to parse user info %o', bangumiUserInfo);
      bangumiUser = null;
    }

    return Observable.of(bangumiUser);
  }

  /**
   * Set access token
   * @returns {StorageService}
   */
  public setAccessToken(token: string): StorageService {
    localStorage.setItem('accessToken', token);

    return this;
  }

  /**
   * Set jwt token
   * @returns {StorageService}
   */
  public setJwtToken(token: string): StorageService {
    localStorage.setItem('jwtToken', token);
    return this;
  }

  /**
   * Set refresh token
   * @returns {StorageService}
   */
  public setRefreshToken(token: string): StorageService {
    localStorage.setItem('refreshToken', token);
    return this;
  }

  /**
   * Set bangumi user info
   * @returns {StorageService}
   */
  public setBangumiUser(bangumiUser: BangumiUser): StorageService {
    localStorage.setItem('bangumiUser', JSON.stringify(bangumiUser));

    return this;
  }

  /**
   * Remove tokens
   */
  public clear() {
    localStorage.removeItem('accessToken');
    localStorage.removeItem('refreshToken');
    localStorage.removeItem('jwtToken');
    localStorage.removeItem('bangumiUser');
  }
}
