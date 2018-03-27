import { Injectable } from '@angular/core';
import {StorageService} from '../storage.service';
import {HttpClient} from '@angular/common/http';
import {environment} from '../../../../environments/environment';

@Injectable()
export class BangumiCollectionService {

  constructor(private http: HttpClient,
              private storageService: StorageService) {

  }

  /**
   * get user collection status
   * only collection that's being watched will be returned per api
   */
  public getOngoingCollection(username: string, category: string) {
    return this.http.get(`${environment.BANGUMI_API_URL}/user/${username}/collection?cat=${category}&app_id=${environment.BANGUMI_APP_ID}`);
  }

}
