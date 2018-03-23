import { Injectable } from '@angular/core';
import {environment} from '../../../../environments/environment';
import {HttpClient} from '@angular/common/http';
import {Observable} from 'rxjs/Observable';
import {StorageService} from '../storage.service';
import {map, switchMap, take, tap} from 'rxjs/operators';
import {BangumiUser} from '../../models/BangumiUser';

@Injectable()
export class BangumiUserService {

  BANGUMI_API_URL = environment.BANGUMI_API_URL;

  constructor(private http: HttpClient,
              private storageService: StorageService) { }

  /*
  get user info
  is username is not provided/null/etc, by default, user info in localStorage will be used to retrieve user info from server
  if there's no user info in localStorage, a null will be emitted
  if
   */
  getUserInfo(username?: string): Observable<any> {
    if (username) {
      return this.http.get(`${this.BANGUMI_API_URL}/user/${username}`);
    }

    return this.storageService.getBangumiUser().pipe(
      take(1),
      switchMap(
        bangumiUserFromStorage => {
          // if user info is in localStorage and username has at least 1 string
          if (bangumiUserFromStorage && bangumiUserFromStorage.username.length >= 1) {
            return this.http.get(`${this.BANGUMI_API_URL}/user/${bangumiUserFromStorage.username}`)
              .pipe(
                map(bangumiUserFromHttp => {
                  const bangumiUser: BangumiUser = new BangumiUser().deserialize(bangumiUserFromHttp);
                  this.storageService.setBangumiUser(bangumiUser);
                  return bangumiUser;
                })
              );
          }

          // else return an empty Observable
          return Observable.of();
        }
      )
    ).catch((err) => {
      return Observable.throw(err);
    });


  }

}
