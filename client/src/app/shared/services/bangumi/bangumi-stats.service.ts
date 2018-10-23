import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {Observable} from 'rxjs';
import {environment} from '../../../../environments/environment';
import {UserStatsSchema} from '../../models/stats/user-stats-schema';
import {SubjectStatsSchema} from '../../models/stats/subject-stats-schema';
import {TranslateService} from '@ngx-translate/core';

@Injectable({
  providedIn: 'root'
})
export class BangumiStatsService {

  constructor(private http: HttpClient,
              private translateService: TranslateService) {
  }

  static isValidDate(date: Date) {
    const BangumiNInitialYear = 2018;
    // if parsed date is invalid: 1. getTime() returns NaN or getFullYear() returns a number that's smaller than the time that BangumiN
    // starts collecting data(not possible)
    return !(isNaN(date.getTime()) || date.getFullYear() < BangumiNInitialYear);
  }

  /**
   * Calculates last update time then converts to locale string
   * @param updateTime epoch time
   */
  public getLastUpdateTime(updateTime: number) {
    const parsedLastUpdateDate = new Date(updateTime);
    if (!BangumiStatsService.isValidDate(parsedLastUpdateDate)) {
      return '-';
    }
    return parsedLastUpdateDate.toLocaleString(this.translateService.currentLang,
      {hour12: false, year: 'numeric', month: 'short', day: 'numeric'});
  }


  /**
   * Get user stats by Id
   * @param userIdOrUsername user id
   */
  public getUserStats(userIdOrUsername: string | number): Observable<UserStatsSchema> {
    return this.http.get<UserStatsSchema>
    (`${environment.BACKEND_API_URL}/stats/user/${userIdOrUsername}`);
  }


  /**
   * Get subject stats by Id
   * @param subjectId subject id
   */
  public getSubjectStats(subjectId: number): Observable<SubjectStatsSchema> {
    return this.http.get<SubjectStatsSchema>
    (`${environment.BACKEND_API_URL}/stats/subject/${subjectId}`);
  }
}
