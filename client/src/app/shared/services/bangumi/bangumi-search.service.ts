import {Injectable} from '@angular/core';
import {Observable, of, throwError} from 'rxjs';
import {HttpClient} from '@angular/common/http';
import {environment} from '../../../../environments/environment';
import {catchError, map, timeout} from 'rxjs/operators';
import {SearchSubjectsResponseSmall} from '../../models/search/search-subjects-response-small';
import {SubjectType} from '../../enums/subject-type.enum';

@Injectable({
  providedIn: 'root'
})
export class BangumiSearchService {

  constructor(private http: HttpClient) {
  }


  /**
   *search through bangumi API
   * https://github.com/bangumi/api/issues/43 currently this API has a strange behaviour: if the result is empty,
   * the API will take a long time to return a response, as a workaround we set a searchTimeout here then return an empty result
   * another strange behaviour is a html might be returned, but the status code is 200, in that case we also initialize an empty result
   * @param keywords word to search
   * @param searchFilterType type of subject
   * @param responseGroup response size, currently only small is supported
   * @param start start token
   * @param max_results maximum number of resul
   * @param searchTimeout timeout for searching
   */
  public searchSubject(keywords: string, searchFilterType = SubjectType.all, responseGroup = 'small',
                       start = 0, max_results = 25, searchTimeout = 5000): Observable<SearchSubjectsResponseSmall> {
    // use replace here to remove redundant white space
    return this.http.get(`${environment.BANGUMI_API_URL}/search/subject/${keywords}?\
    app_id=${environment.BANGUMI_APP_ID}&\
    type=${searchFilterType}&\
    responseGroup=${responseGroup}&\
    start=${start}&\
    max_results=${max_results}`.replace(/\s+/g, ''))
      .pipe(
        timeout(searchTimeout),
        map(
          (response: any) => {
            let searchResult: SearchSubjectsResponseSmall;
            // parse 404 result into a object that's same as others
            if (response) {
              if (response['code'] === 404) {
                searchResult = new SearchSubjectsResponseSmall();
              } else {
                searchResult = new SearchSubjectsResponseSmall().deserialize(response, searchFilterType);
              }
            } else {
              searchResult = new SearchSubjectsResponseSmall();
            }

            return searchResult;
          }
        ),
        catchError(error => {
          // in case of status 200 or timeout, we'll handle it silently
          if (error.status === 200 || error.name === 'TimeoutError') {
            return of(new SearchSubjectsResponseSmall());
          } else {
            return throwError(error);
          }
        })
      );
  }

}
