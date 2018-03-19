import { Injectable } from '@angular/core';
import {environment} from '../../../../environments/environment';
import {HttpClient} from '@angular/common/http';

@Injectable()
export class BangumiUserService {

  BANGUMI_API_URL = environment.BANGUMI_API_URL;

  constructor(private http: HttpClient) { }

  getUserInfo(username: string) {
    return this.http.get(`${this.BANGUMI_API_URL}/user/${username}`);
  }

}
