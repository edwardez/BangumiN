import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {Observable} from 'rxjs/Observable';
import {environment} from '../../../../environments/environment';

@Injectable()
export class BangumiSubjectService {

  constructor(private http: HttpClient) {
  }

  public getSubject(subject_id: string, responseGroup = 'small'): Observable<any> {

    return this.http.get(`${environment.BANGUMI_API_URL}/subject/${subject_id}?responseGroup=${responseGroup}`);


  }



}
