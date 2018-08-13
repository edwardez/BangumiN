import {Injectable} from '@angular/core';
import {Observable} from 'rxjs';
import {HttpClient} from '@angular/common/http';
import {environment} from '../../../../environments/environment';
import {map} from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class BangumiSearchService {

  constructor(private http: HttpClient) {
  }

  public searchSubject(keywords: string, type = '', responseGroup = 'small', start = 0, max_results = 25): Observable<any> {
    // use replace here to remove redundant white space
    return this.http.get(`${environment.BANGUMI_API_URL}/search/subject/${keywords}?\
    app_id=${environment.BANGUMI_APP_ID}&\
    type=${type}&\
    responseGroup=${responseGroup}&\
    start=${start}&\
    max_results=${max_results}`.replace(/\s+/g, ''))
      .pipe(
        map(
          response => {
            // parse 404 result into a object that's same as others
            if (response['code'] && response['code'] === 404) {
              return {'results': 0, 'list': [], 'type': Number(type)};
            }

            response['type'] = Number(type);
            return response;
          }
        )
      );
  }

}
