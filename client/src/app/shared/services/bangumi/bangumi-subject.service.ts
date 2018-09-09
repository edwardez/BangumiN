import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {Observable} from 'rxjs';
import {environment} from '../../../../environments/environment';
import {SubjectSmall} from '../../models/subject/subject-small';
import {SubjectLarge} from '../../models/subject/subject-large';
import {SubjectMedium} from '../../models/subject/subject-medium';
import {map} from 'rxjs/operators';
import {SubjectEpisodes} from '../../models/subject/subject-episodes';
import {SubjectBase} from '../../models/subject/subject-base';

@Injectable({
  providedIn: 'root'
})
export class BangumiSubjectService {

  constructor(private http: HttpClient) {
  }

  /**get subject info
   * if useBangumiAPI is set to false, BangumiN's API will be used
   * @param subject_id id
   * @param responseGroup size of response
   * @param useBangumiAPI whether Bangumi's official API should be called
   */
  public getSubject(subject_id: string | number, responseGroup = 'small', useBangumiAPI = false):
    Observable<SubjectMedium> | Observable<SubjectLarge> | Observable<SubjectSmall> {
    let httpRequest: Observable<any>;

    if (useBangumiAPI) {
      // base doesn't exist on Bangumi's API
      if (responseGroup === 'base') {
        responseGroup = 'small';
      }
      httpRequest = this.http.get(`${environment.BANGUMI_API_URL}/subject/${subject_id}?responseGroup=${responseGroup}`);
    } else {
      const options = {withCredentials: true};
      httpRequest = this.http.get(`${environment.BACKEND_API_URL}/bgm/subject/${subject_id}?responseGroup=${responseGroup}`, options);
    }

    return httpRequest
      .pipe(
        map(res => {
          switch (responseGroup) {
            case 'base':
              return new SubjectBase().deserialize(res);
            case 'small ':
              return new SubjectSmall().deserialize(res);
            case 'medium':
              return new SubjectMedium().deserialize(res);
            case 'large':
              return new SubjectLarge().deserialize(res);
            default:
              return new SubjectSmall().deserialize(res);
          }
        })
      );
  }

  public getSubjectEpisode(subject_id: string): Observable<SubjectEpisodes> {

    return this.http.get(`${environment.BANGUMI_API_URL}/subject/${subject_id}/ep`)
      .pipe(
        map(res => {
          if (res['code'] && res['code'] !== 200) {
            return new SubjectEpisodes();
          } else {
            return new SubjectEpisodes().deserialize(res);
          }

        })
      );
  }


}
