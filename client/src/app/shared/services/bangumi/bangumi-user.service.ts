import {Observable, of, throwError as observableThrowError} from 'rxjs';
import {Injectable} from '@angular/core';
import {environment} from '../../../../environments/environment';
import {HttpClient} from '@angular/common/http';
import {StorageService} from '../storage.service';
import {catchError, map, switchMap, take} from 'rxjs/operators';
import {BangumiUser} from '../../models/BangumiUser';
import {RuntimeConstantsService} from '../runtime-constants.service';

// import * as PriorityQueue from 'js-priority-queue';

@Injectable({
  providedIn: 'root'
})
export class BangumiUserService {

  BANGUMI_API_URL = environment.BANGUMI_API_URL;

  constructor(private http: HttpClient,
              private storageService: StorageService,) {
  }

  /**
   * Get user info from web api
   * if useBangumiAPI is set to false, BangumiN's API will be used
   * @param username user name, can be integer or string
   * @param useBangumiAPI whether Bangumi's official API should be called
   */
  public getUserInfoFromHttp(username: string | number, useBangumiAPI = false): Observable<BangumiUser> {
    let httpRequest: Observable<any>;

    if (useBangumiAPI) {
      httpRequest = this.http.get(`${environment.BANGUMI_API_URL}/user/${username}`);
    } else {
      const options = {withCredentials: true};
      httpRequest = this.http.get(`${environment.BACKEND_API_URL}/bgm/user/${username}`, options);
    }


    return httpRequest.pipe(
      map(bangumiUserFromHttp => {
        if (bangumiUserFromHttp) {
          return new BangumiUser().deserialize(bangumiUserFromHttp);
        }
        return new BangumiUser();
      })
    );
  }


  /**
   get user info
   is username is not provided/null/etc, by default, user info in localStorage will be used to retrieve user info from server
   if there's no user info in localStorage, a null will be emitted
   if
   */
  getUserSettings(username?: string): Observable<any> {
    if (username) {
      return this.getUserInfoFromHttp(username, false);
    }

    return this.storageService.getBangumiUser().pipe(
      take(1),
      switchMap(
        bangumiUserFromStorage => {
          // if user info is in localStorage and username has at least 1 string
          // first use our api to avoid reaching bangumi API rate limit
          if (bangumiUserFromStorage && bangumiUserFromStorage.username.length >= 1) {
            return this.getUserInfoFromHttp(bangumiUserFromStorage.username, false)
              .pipe(
                switchMap(
                  bangumiUserFromHttp => {
                    if (bangumiUserFromHttp.id !== RuntimeConstantsService.defaultBangumiUserId) {
                      return of(bangumiUserFromHttp);
                    } else {
                      // if the user cannot be found, probably it's not cached in our db yet, then use Bangumi's API
                      return this.getUserInfoFromHttp(bangumiUserFromStorage.username, true);
                    }
                  }
                ),
                map(bangumiUserFromHttp => {
                  this.storageService.setBangumiUser(bangumiUserFromHttp);
                  return bangumiUserFromHttp;
                })
              );
          }

          // else return an empty Observable
          return of();
        }
      ),
      catchError((err) => {
        return observableThrowError(err);
      })
    );
  }


}
