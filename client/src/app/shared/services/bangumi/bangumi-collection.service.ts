import {Injectable} from '@angular/core';
import {StorageService} from '../storage.service';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import {environment} from '../../../../environments/environment';
import {map} from 'rxjs/operators';
import {Observable} from 'rxjs';
import {CollectionResponse} from '../../models/collection/collection-response';
import {CollectionRequest} from '../../models/collection/collection-request';
import {StatusCode} from '../../models/common/status-code';
import {SubjectWatchingCollectionMedium} from '../../models/subject/subject-watching-collection-medium';

@Injectable({
  providedIn: 'root'
})
export class BangumiCollectionService {

  constructor(private http: HttpClient,
              private storageService: StorageService) {

  }

  /**
   * test whether the number is valid
   * in order to qualify, it must not be a undefined/null value
   * and it must only contain numbers, or dot(.)
   * @param {string} id episode id
   * @returns {boolean} whether it's valid
   */
  static isValidEpisodeSortNumber(id: string): boolean {
    return id !== undefined && id !== null && /^\d+\.*\d*$/.test(id);
  }

  /**
   * test whether the number is valid
   * in order to qualify, it must not be a undefined/null positive integer
   * @param {string} id volume number
   * @returns {boolean} whether it's valid
   */
  static isValidVolumeNumber(id: string): boolean {
    return id !== undefined && id !== null && id !== environment.invalidVolume && /^\d+$/.test(id) && parseInt(id, 10) >= 0;
  }


  /**
   * get user collection status
   * only collection that's being watched will be returned per api
   */
  public getSubjectCollectionStatus(subjectId: string): Observable<CollectionResponse> {
    return this.http.get(`${environment.BANGUMI_API_URL}/collection/${subjectId}?app_id=${environment.BANGUMI_APP_ID}`)
      .pipe(
        map(res => {
            if (res['code'] && res['code'] !== 200) {
              return new CollectionResponse();
            } else {
              return new CollectionResponse().deserialize(res);
            }
          }
        )
      );
  }


  /**
   * create or update user collection status
   * it's a 'upsert' action per doc so :action will be fixed to update
   */
  public upsertSubjectCollectionStatus(
    subjectId: string, collectionRequest: CollectionRequest,
    action = 'update'): Observable<CollectionResponse> {
    const collectionRequestBody = new URLSearchParams();

    if (collectionRequest.status !== undefined) {
      collectionRequestBody.set('status', collectionRequest.status);
    }

    if (collectionRequest.comment !== undefined) {
      collectionRequestBody.set('comment', collectionRequest.comment);
    }

    if (collectionRequest.tags !== undefined) {
      collectionRequestBody.set('tags', collectionRequest.tags.map(tag => tag.trim()).filter(tag => tag.trim().length >= 1).join(' '));
    }

    if (collectionRequest.rating !== undefined) {
      collectionRequestBody.set('rating', collectionRequest.rating.toString());
    }

    if (collectionRequest.privacy !== undefined) {
      collectionRequestBody.set('privacy', collectionRequest.privacy.toString());
    }


    const headers = new HttpHeaders().set('Content-Type', 'application/x-www-form-urlencoded');

    return this.http.post<CollectionResponse>
    (`${environment.BANGUMI_API_URL}/collection/${subjectId}/update?app_id=${environment.BANGUMI_APP_ID}`,
      collectionRequestBody.toString(), {headers: headers, withCredentials: true})
      .pipe(
        map(res => {
            if (res['code'] && res['code'] !== 200) {
              throw Error('Failed to update response'); // todo: handle exception
            } else {
              return new CollectionResponse().deserialize(res);
            }
          }
        )
      );
  }

  /**
   * update status of an episode
   * @param {number} episodeID episode id
   * @param {string} status Available values : watched, queue, drop, remove
   * @returns {Observable<StatusCode>} status code model
   */
  public upsertEpisodeStatus(episodeID: number, status: string): Observable<StatusCode> {
    const episodeStatusUpdateRequestBody = new URLSearchParams();
    const headers = new HttpHeaders().set('Content-Type', 'application/x-www-form-urlencoded');

    return this.http.post(`${environment.BANGUMI_API_URL}/ep/${episodeID}/status/${status}`,
      episodeStatusUpdateRequestBody.toString(), {headers: headers})
      .pipe(
        map(res => {
          return new StatusCode().deserialize(res);
        })
      );
  }

  /**
   *update episode status of a subject in batch mode
   * for book subject, either watched_eps or watched_vols should be present
   * @param {SubjectWatchingCollectionMedium} subject model
   * @param {string} watchedEpisode watch until this episode number
   * @param {string} watchedVolumes watch until this volume number
   * @returns {Observable<StatusCode>} status code model
   */
  public upsertEpisodeStatusBatch(subject: SubjectWatchingCollectionMedium,
                                  watchedEpisode: string,
                                  watchedVolumes: string)
    : Observable<StatusCode> {
    const episodeStatusUpdateRequestBody = new URLSearchParams();

    if (BangumiCollectionService.isValidEpisodeSortNumber(watchedEpisode)) {
      episodeStatusUpdateRequestBody.set('watched_eps', watchedEpisode);
    }

    if (BangumiCollectionService.isValidVolumeNumber(watchedVolumes) && watchedVolumes !== environment.invalidVolume) {
      episodeStatusUpdateRequestBody.set('watched_vols', watchedVolumes);
    }

    const headers = new HttpHeaders().set('Content-Type', 'application/x-www-form-urlencoded');

    return this.http.post(`${environment.BANGUMI_API_URL}/subject/${subject.id}/update/watched_eps`,
      episodeStatusUpdateRequestBody.toString(), {headers: headers})
      .pipe(
        map(res => {
          return new StatusCode().deserialize(res);
        })
      );
  }

}
