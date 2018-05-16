import {Injectable} from '@angular/core';
import {StorageService} from '../storage.service';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import {environment} from '../../../../environments/environment';
import {map} from 'rxjs/operators';
import {Observable} from 'rxjs';
import {CollectionResponse} from '../../models/collection/collection-response';
import {CollectionRequest} from '../../models/collection/collection-request';
import {CollectionWatchingResponseMedium} from '../../models/collection/collection-watching-response-medium';

@Injectable()
export class BangumiCollectionService {

  constructor(private http: HttpClient,
              private storageService: StorageService) {

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
    collectionRequestBody.set('status', collectionRequest.status);
    collectionRequestBody.set('comment', collectionRequest.comment);
    collectionRequestBody.set('tags', collectionRequest.tags.map(tag => tag.trim()).filter(tag => tag.trim().length >= 1).join(' '));
    collectionRequestBody.set('rating', collectionRequest.rating.toString());
    collectionRequestBody.set('privacy', collectionRequest.privacy.toString());

    const headers = new HttpHeaders().set('Content-Type', 'application/x-www-form-urlencoded');

    return this.http.post<CollectionResponse>
    (`${environment.BANGUMI_API_URL}/collection/${subjectId}/update?app_id=${environment.BANGUMI_APP_ID}`,
      collectionRequestBody.toString(), {headers: headers})
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

}
