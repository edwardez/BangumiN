import {forkJoin, Observable, of, throwError as observableThrowError} from 'rxjs';
import {Injectable} from '@angular/core';
import {environment} from '../../../../environments/environment';
import {HttpClient} from '@angular/common/http';
import {StorageService} from '../storage.service';
import {catchError, map, switchMap, take} from 'rxjs/operators';
import {BangumiUser} from '../../models/BangumiUser';
import {CollectionWatchingResponseMedium} from '../../models/collection/collection-watching-response-medium';
import {UserProgress} from '../../models/progress/user-progress';
import {AuthenticationService} from '../auth.service';
import {SubjectType} from '../../enums/subject-type.enum';
import {SubjectProgress} from '../../models/progress/subject-progress';
import {BangumiSubjectService} from './bangumi-subject.service';
// import * as PriorityQueue from 'js-priority-queue';
import {UserCollectionResponse} from '../../models/collection/user-collection-response';

@Injectable({
  providedIn: 'root'
})
export class BangumiUserService {

  BANGUMI_API_URL = environment.BANGUMI_API_URL;

  constructor(private http: HttpClient,
              private storageService: StorageService,
              private bangumiSubjectService: BangumiSubjectService,
              private authService: AuthenticationService) {
  }


  // /**
  //  * Add episode to a heap, sequence number is the 'sort' number from bangumi episode
  //  * a heap is needed because
  //  * 1. easier to use than an Array, and it's more quickly
  //  * 2. we need to find the next/previous episode, while sort number might not be a integer, heap has advantage on handling this
  //  * @param {SubjectProgress} subjectProgress
  //  * @param {SubjectEpisodes} subjectEpisodes
  //  * @param {number} maxEpisodeCount
  //  * @returns {module:js-priority-queue.PriorityQueue<Episode>}
  //  */
  // static addEpisodeToHeap(subjectProgress: SubjectProgress, subjectEpisodes: SubjectEpisodes, maxEpisodeCount: number)
  //   : PriorityQueue<Episode> {
  //
  //   // calculate the max/min episode sort number(in episodes that user has watched) under each category
  //   // this number is needed because we need to show the first unwatched episode to users
  //   subjectEpisodes.episodes.reduce((updatedEpisode, currentValue) => {
  //     if (subjectProgress.episodesObject[currentValue.id]) {
  //       currentValue['userCollectionStatus'] = subjectProgress.episodesObject[currentValue.id].status.id;
  //       subjectProgress.episodeSortMinMaxByType[currentValue.type].max =
  //         Math.max(subjectProgress.episodeSortMinMaxByType[currentValue.type].max, currentValue.sort);
  //       subjectProgress.episodeSortMinMaxByType[currentValue.type].min =
  //         Math.min(subjectProgress.episodeSortMinMaxByType[currentValue.type].min, currentValue.sort);
  //     }
  //     updatedEpisode.push(currentValue);
  //
  //     return updatedEpisode;
  //   }, []);
  //
  //   const priorityQueue: PriorityQueue<Episode> = new PriorityQueue({
  //     comparator: function (a, b) {
  //       return a['sort'] - b['sort'];
  //     }
  //   });
  //
  //   const totalEpisodesCount: number = subjectEpisodes.episodes.length;
  //   for (const subjectEpisode of  subjectEpisodes.episodes) {
  //     // break if more than required number of episode is fetched
  //     if (priorityQueue.length >= maxEpisodeCount) {
  //       break;
  //     }
  //
  //     if (totalEpisodesCount <= maxEpisodeCount ||
  //       subjectEpisode.sort >= subjectProgress.episodeSortMinMaxByType[subjectEpisode.type].max) {
  //       priorityQueue.queue(subjectEpisode);
  //     }
  //     // add episode to a priority queue
  //
  //   }
  //
  //   return priorityQueue;
  // }

  /**
   * for subject that's a show(real/anime) but user hasn't touched them, generate a fake SubjectProgress object
   * this is required because API doesn't return episode info for untouched shows
   * while user will need to update progress for shows that they haven't been touched
   * this is a in-place modification(since object is modified)
   * it would be better if we can refactor this into a pure function
   * @param {[UserProgress , CollectionWatchingResponseMedium[]]} collectionStatus
   * @returns {[UserProgress , CollectionWatchingResponseMedium[]]}
   */
  static generateFakeProgressForUntouchedSubject(collectionStatus: [UserProgress, CollectionWatchingResponseMedium[]]):
    [UserProgress, CollectionWatchingResponseMedium[]] {

    const ongoingTouchedShowProgress = collectionStatus[0];
    const ongoingCollectionStatus = collectionStatus[1];

    // get all show ids no matter user has at least marked one episode or not
    const ongoingAllShowIDs: number[] = ongoingCollectionStatus.reduce((updatedArray, currentSubject) => {
      if ([SubjectType.anime, SubjectType.real].indexOf(currentSubject.subject.type) !== -1) {
        updatedArray.push(currentSubject.id);
      }
      return updatedArray;
    }, []);

    // get show ids for subject that user has at least marked one episode
    const ongoingTouchedShowProgressIDs: number[] =
      ongoingTouchedShowProgress.progress.reduce((updatedArray, currentSubject) => {
        updatedArray.push(currentSubject.id);
        return updatedArray;
      }, []);

    // for untouched shows, generate a fake SubjectProgress
    ongoingAllShowIDs.forEach(id => {
      if (ongoingTouchedShowProgressIDs.indexOf(id) === -1) {
        // add a fake progress for untouched shows
        ongoingTouchedShowProgress.progress.push(new SubjectProgress(id));
      }
    });

    return collectionStatus;
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
        return new BangumiUser().deserialize(bangumiUserFromHttp);
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
          if (bangumiUserFromStorage && bangumiUserFromStorage.username.length >= 1) {
            return this.getUserInfoFromHttp(bangumiUserFromStorage.username, true).pipe(
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

  /**
   * get user collection detail info by type
   */
  public getUserCollectionByType(userName: string, subjectType: string, max_results = 25): Observable<UserCollectionResponse> {
    return this.http.get(`${environment.BANGUMI_API_URL}/user/${userName}/collections/${subjectType}
    ?app_id=${environment.BANGUMI_APP_ID}
    &max_results=${max_results}`.replace(/\s+/g, ''))
      .pipe(
        map(res => {
            if (res !== null) {
              return new UserCollectionResponse().deserialize(res);
            } else {
              // if user has no collection item under this category, a null will be returned
              return new UserCollectionResponse(SubjectType[subjectType]);
            }
          }
        )
      );
  }

  /**
   * get all subjects that user is watching
   * if cat is all_watching, collection = show + books
   * note: only book/anime/real status will be returned per api
   * it's an overview, no progress episode info is returned
   */
  public getOngoingCollectionStatus(userName: string,
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
   * get all shows progress that user is watching
   * different from getOngoingCollectionStatus, it's not a overview, episode info will be returned
   * i.e. how many episodes have been watched/dropped/etc
   * note1: show = anime/real, per api
   * note2: if user start watching a subject, but hasn't marked any episode, then nothing will be returned
   * (hence the name ,touched show)
   */
  public getOngoingTouchedShowProgress(userName: string,
                                       subject_id = ''): Observable<UserProgress> {
    return this.http.get(`${environment.BANGUMI_API_URL}/user/${userName}/progress
    ?app_id=${environment.BANGUMI_APP_ID}&
      ${/\D+|^$/.test(subject_id) ? '' : '?subject_id=' + subject_id}`
      .replace(/\s+/g, ''))
      .pipe(
        map(res => {
          // console.log(res === null)
          if (res === null || (res['code'] && res['code'] !== 200)) {
            return new UserProgress();
          } else {
            return new UserProgress().deserialize(res);
          }
        })
      );
  }

  // /**
  //  * get ongoing subject info, show progress episode info and store them in required data structure
  //  * this method is required because relevant info is not directly available in any single API call
  //  * and further calculation is needed
  //  * @returns {Observable<any>}
  //  */
  // public getOngoingCollectionStatusAndProgress(): Observable<CollectionWatchingResponseMedium[]> {
  //   return this.authService.userSubject
  //     .pipe(
  //       first(), // we only need user id, which is unlikely to be updated, so only first value(in localStorage) is needed,
  //       switchMap(userInfo => {
  //           const userID: string = userInfo['user_id'].toString();
  //           return forkJoin([
  //             this.getOngoingTouchedShowProgress(userID),
  //             this.getOngoingCollectionStatus(userID)
  //           ]).pipe(
  //             map(collectionStatus => {
  //               return BangumiUserService.generateFakeProgressForUntouchedSubject(collectionStatus);
  //             })
  //           );
  //         }
  //       ),
  //       switchMap(collectionStatus => {
  //         const ongoingAllShowProgress = collectionStatus[0];
  //         return this.buildObservableArrayForOngoingCollectionStatusAndProgress(collectionStatus[0])
  //           .pipe(
  //             map(
  //               response => ({
  //                 collectionWatchingResponses: collectionStatus[1],
  //                 ongoingAllShow: response
  //               }))
  //           );
  //       }),
  //       map(
  //         response => {
  //           // for each show, update its episodeHeap
  //           response['ongoingAllShow'].forEach(
  //             show => {
  //               const priorityQueue: PriorityQueue<Episode> = BangumiUserService.addEpisodeToHeap(
  //                 show['subjectProgress'],
  //                 show['subjectEpisodes'],
  //                 environment.progressPageMaxEpisodeCountDesktop);
  //
  //               // in collectionWatchingResponses, find the matched response
  //               const matchedCollection = response['collectionWatchingResponses'].find(
  //                 collection => collection.id === show['subjectProgress'].id);
  //               // theoretically we should be able to find one, but if there's no such collection, skip the assignment
  //               if (matchedCollection !== undefined) {
  //                 matchedCollection.episodeHeap = priorityQueue;
  //
  //                 if (priorityQueue.length !== 0 && matchedCollection.subject.totalEpisodesCount === 0) {
  //                   matchedCollection.subject.totalEpisodesCount = show['subjectEpisodes'].episodes.length;
  //                 }
  //               }
  //
  //             }
  //           );
  //
  //           return response['collectionWatchingResponses'];
  //         }
  //       )
  //     );
  // }

  private buildObservableArrayForOngoingCollectionStatusAndProgress(ongoingAllShowProgress: UserProgress): any {
    const observableArray = [
      ...ongoingAllShowProgress.progress.map(episode =>
        this.bangumiSubjectService.getSubjectEpisode(episode.id.toString())
          .pipe(
            map(
              episodeInfo => {
                return {
                  subjectProgress: ongoingAllShowProgress.progress.find(ep => ep.id === episode.id),
                  subjectEpisodes: episodeInfo
                };
              })
          ))];

    if (observableArray.length === 0) {
      return of(observableArray);
    } else {
      return forkJoin(observableArray);
    }

  }

}
