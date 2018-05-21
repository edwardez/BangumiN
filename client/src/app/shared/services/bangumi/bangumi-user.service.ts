
import {throwError as observableThrowError, Observable, of} from 'rxjs';
import { Injectable } from '@angular/core';
import {environment} from '../../../../environments/environment';
import {HttpClient} from '@angular/common/http';
import {StorageService} from '../storage.service';
import {catchError, map, switchMap, take, tap} from 'rxjs/operators';
import {BangumiUser} from '../../models/BangumiUser';
import {CollectionWatchingResponseMedium} from '../../models/collection/collection-watching-response-medium';
import {UserProgress} from '../../models/progress/user-progress';

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
          return of();
        }
      ),
      catchError((err) => {
        return observableThrowError(err);
      })
    );
  }

  /**
   * get all subjects that user is watching
   * note: only book/anime/real status will be returned per api
   */
  public getOngoingCollectionStatusOverview(userName: string,
                                            cat = 'all_watching',
                                            ids = '',
                                            responseGroup = 'medium'): Observable<CollectionWatchingResponseMedium[]> {
    return this.http.get(`${environment.BANGUMI_API_URL}/user/${userName}/collection
    ?app_id=${environment.BANGUMI_APP_ID}
    &cat=${cat}
    &ids=${ids}
    &responseGroup=${responseGroup}`.replace(/\s+/g, ''))
      .pipe(
        map(res => {
            if (res instanceof Array) {
              const parsedResponse = [];
              for (const collection of res) {

                parsedResponse.push(new CollectionWatchingResponseMedium().deserialize(collection));
              }
              return parsedResponse;
            } else {
              return [];
            }
          }
        )
      );
  }

  /**
   * get all anime/real progress that user is watching
   * different from getOngoingCollectionStatusOverview, it's not a overview
   * only episode progress info will be returned
   * note: only anime/real status will be returned per api
   */
  public getOngoingProgressEpisodeDetail(userName: string,
                                           subject_id = ''): Observable<UserProgress> {
    return this.http.get(`${environment.BANGUMI_API_URL}/user/${userName}/progress
    ?app_id=${environment.BANGUMI_APP_ID}&
    ${subject_id === '' || isNaN(Number(subject_id)) ? '' : '?subject_id=' + subject_id}`
      .replace(/\s+/g, ''))
      .pipe(
        map(res => {
          if (res['code'] && res['code'] !== 200) {
            return new UserProgress();
          } else {
            return new UserProgress().deserialize(res);
          }
        } )
      );
  }


}
