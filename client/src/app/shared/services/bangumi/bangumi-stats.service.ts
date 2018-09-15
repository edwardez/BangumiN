import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {Observable} from 'rxjs';
import {environment} from '../../../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class BangumiStatsService {

  constructor(private http: HttpClient) {
  }

  /**
   * Get user stats by Id
   * @param userIdOrUsername user id
   */
  public getUserStats(userIdOrUsername: string | number): Observable<any> {
    return this.http.get
    (`${environment.BACKEND_API_URL}/stats/user/${userIdOrUsername}`);
  }


  /**
   * Get subject stats by Id
   * @param subjectId subject id
   */
  public getSubjectStats(subjectId: number): Observable<any> {
    return this.http.get
    (`${environment.BACKEND_API_URL}/stats/subject/${subjectId}`);
  }
}
