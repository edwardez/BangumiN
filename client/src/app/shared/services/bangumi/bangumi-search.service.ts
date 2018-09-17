import {Injectable} from '@angular/core';
import {Observable, of, throwError} from 'rxjs';
import {HttpClient} from '@angular/common/http';
import {environment} from '../../../../environments/environment';
import {catchError, map, timeout} from 'rxjs/operators';
import {SearchSubjectsResponseSmall} from '../../models/search/search-subjects-response-small';
import {SubjectType} from '../../enums/subject-type.enum';
import {BanguminStyleUserBatchSearchResponse} from '../../models/search/bangumin-style-batch-search-response';
import {BangumiUser} from '../../models/BangumiUser';

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

  public searchUserByNickname(nickname: string, fullMatch = false, offset = 0,
                              limit = 10): Observable<BanguminStyleUserBatchSearchResponse> {
    const options = {withCredentials: true};
    // return of({
    //   'count': 389,
    //   'rows': [{
    //     'id': 226562,
    //     'username': '226562',
    //     'nickname': 'aasssa',
    //     'url': 'http://bgm.tv/user/226562',
    //     'avatar': {
    //       'large': 'http://lain.bgm.tv/pic/user/l/icon.jpg',
    //       'small': 'http://lain.bgm.tv/pic/user/s/icon.jpg',
    //       'medium': 'http://lain.bgm.tv/pic/user/m/icon.jpg'
    //     },
    //     'sign': '',
    //     'user_group': 10
    //   }, {
    //     'id': 229933,
    //     'username': '229933',
    //     'nickname': 'asssa',
    //     'url': 'http://bgm.tv/user/229933',
    //     'avatar': {
    //       'large': 'http://lain.bgm.tv/pic/user/l/icon.jpg',
    //       'small': 'http://lain.bgm.tv/pic/user/s/icon.jpg',
    //       'medium': 'http://lain.bgm.tv/pic/user/m/icon.jpg'
    //     },
    //     'sign': '',
    //     'user_group': 10
    //   }, {
    //     'id': 229936,
    //     'username': '229936',
    //     'nickname': 'dssssssss',
    //     'url': 'http://bgm.tv/user/229936',
    //     'avatar': {
    //       'large': 'http://lain.bgm.tv/pic/user/l/000/22/99/229936.jpg?r=1422070647',
    //       'small': 'http://lain.bgm.tv/pic/user/s/000/22/99/229936.jpg?r=1422070647',
    //       'medium': 'http://lain.bgm.tv/pic/user/m/000/22/99/229936.jpg?r=1422070647'
    //     },
    //     'sign': 'ddddddddddd',
    //     'user_group': 10
    //   }, {
    //     'id': 231396,
    //     'username': 'hzx443945604',
    //     'nickname': 'sss',
    //     'url': 'http://bgm.tv/user/hzx443945604',
    //     'avatar': {
    //       'large': 'http://lain.bgm.tv/pic/user/l/icon.jpg',
    //       'small': 'http://lain.bgm.tv/pic/user/s/icon.jpg',
    //       'medium': 'http://lain.bgm.tv/pic/user/m/icon.jpg'
    //     },
    //     'sign': 'gh',
    //     'user_group': 10
    //   }, {
    //     'id': 232340,
    //     'username': '232340',
    //     'nickname': 'ssss',
    //     'url': 'http://bgm.tv/user/232340',
    //     'avatar': {
    //       'large': 'http://lain.bgm.tv/pic/user/l/icon.jpg',
    //       'small': 'http://lain.bgm.tv/pic/user/s/icon.jpg',
    //       'medium': 'http://lain.bgm.tv/pic/user/m/icon.jpg'
    //     },
    //     'sign': '',
    //     'user_group': 10
    //   }, {
    //     'id': 232822,
    //     'username': 'cycy25',
    //     'nickname': 'ctgsss',
    //     'url': 'http://bgm.tv/user/cycy25',
    //     'avatar': {
    //       'large': 'http://lain.bgm.tv/pic/user/l/000/23/28/232822.jpg?r=1423533481',
    //       'small': 'http://lain.bgm.tv/pic/user/s/000/23/28/232822.jpg?r=1423533481',
    //       'medium': 'http://lain.bgm.tv/pic/user/m/000/23/28/232822.jpg?r=1423533481'
    //     },
    //     'sign': '1234567',
    //     'user_group': 10
    //   }, {
    //     'id': 233408,
    //     'username': '233408',
    //     'nickname': 'sssssss',
    //     'url': 'http://bgm.tv/user/233408',
    //     'avatar': {
    //       'large': 'http://lain.bgm.tv/pic/user/l/icon.jpg',
    //       'small': 'http://lain.bgm.tv/pic/user/s/icon.jpg',
    //       'medium': 'http://lain.bgm.tv/pic/user/m/icon.jpg'
    //     },
    //     'sign': '',
    //     'user_group': 10
    //   }, {
    //     'id': 235558,
    //     'username': 'qqqqqqqqqq',
    //     'nickname': 'afssffsssfsf',
    //     'url': 'http://bgm.tv/user/qqqqqqqqqq',
    //     'avatar': {
    //       'large': 'http://lain.bgm.tv/pic/user/l/icon.jpg',
    //       'small': 'http://lain.bgm.tv/pic/user/s/icon.jpg',
    //       'medium': 'http://lain.bgm.tv/pic/user/m/icon.jpg'
    //     },
    //     'sign': 'qqqqq',
    //     'user_group': 10
    //   }, {
    //     'id': 235815,
    //     'username': '235815',
    //     'nickname': 'sss',
    //     'url': 'http://bgm.tv/user/235815',
    //     'avatar': {
    //       'large': 'http://lain.bgm.tv/pic/user/l/icon.jpg',
    //       'small': 'http://lain.bgm.tv/pic/user/s/icon.jpg',
    //       'medium': 'http://lain.bgm.tv/pic/user/m/icon.jpg'
    //     },
    //     'sign': '',
    //     'user_group': 10
    //   }, {
    //     'id': 235906,
    //     'username': '235906',
    //     'nickname': 'wsss',
    //     'url': 'http://bgm.tv/user/235906',
    //     'avatar': {
    //       'large': 'http://lain.bgm.tv/pic/user/l/icon.jpg',
    //       'small': 'http://lain.bgm.tv/pic/user/s/icon.jpg',
    //       'medium': 'http://lain.bgm.tv/pic/user/m/icon.jpg'
    //     },
    //     'sign': '',
    //     'user_group': 10
    //   }]
    // }).pipe(
    //     map( response => new BanguminStyleUserBatchSearchResponse().deserialize(response))
    //   );
    return this.http.get<BangumiUser[]>(
      `${environment.BACKEND_API_URL}/search/user/${nickname}?fullMatch=${fullMatch}&offset=${offset}&limit=${limit}`, options)
      .pipe(
        map(response => new BanguminStyleUserBatchSearchResponse().deserialize(response))
      );
  }

}
