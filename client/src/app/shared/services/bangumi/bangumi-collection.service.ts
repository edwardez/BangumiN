import {Injectable} from '@angular/core';
import {StorageService} from '../storage.service';
import {HttpClient} from '@angular/common/http';
import {environment} from '../../../../environments/environment';
import {map} from 'rxjs/operators';
import {Observable} from 'rxjs/Observable';

@Injectable()
export class BangumiCollectionService {

  constructor(private http: HttpClient,
              private storageService: StorageService) {

  }

  /**
   * get user collection status
   * only collection that's being watched will be returned per api
   */
  public getOngoingCollectionStatus(username: string, category: string) {
    return this.http.get(`${environment.BANGUMI_API_URL}/user/${username}/collection?cat=${category}&app_id=${environment.BANGUMI_APP_ID}`);
  }

  /**
   * get user collection status
   * only collection that's being watched will be returned per api
   */
  public getSubjectCollectionStatus(subjectId: string): Observable<any> {
    return this.http.get(`${environment.BANGUMI_API_URL}/collection/${subjectId}?app_id=${environment.BANGUMI_APP_ID}`)
      .pipe(
        map(res => {
            if (res['code'] && res['code'] !== 200) {
              return undefined;
            } else {
              return res;
            }
          }
        )
      );
  }

}
