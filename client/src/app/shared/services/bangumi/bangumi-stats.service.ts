import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {Observable} from 'rxjs';
import {environment} from '../../../../environments/environment';
import {UserStatsSchema} from '../../models/stats/user-stats-schema';
import {SubjectStatsSchema} from '../../models/stats/subject-stats-schema';
import {TranslateService} from '@ngx-translate/core';
import {RecordSchema} from '../../models/stats/record-schema';
import {map} from 'rxjs/operators';
import meanBy from 'lodash/meanBy';
import sortBy from 'lodash/sortBy';
import sum from 'lodash/sum';

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
   * Calculates descriptive chart data, mean, median and standard deviation are calculated and names are translated to corresponding labels
   * @param records
   */
  public calculateDescriptiveChartData(records: RecordSchema[]): Observable<{ name: string, value: number }[]> {
    // filter null rate
    records = records.filter(stat => stat.rate);
    const len = records.length;
    let mean, median, stdDev;
    if (len === 0) {
      mean = 0;
      median = 0;
      stdDev = 0;
    } else {
      mean = meanBy(records, 'rate');
      const middle = (len + 1) / 2, sorted = sortBy(records, 'rate');
      median = (sorted.length % 2) ? sorted[middle - 1].rate : (sorted[middle - 1.5].rate + sorted[middle - 0.5].rate) / 2;
      stdDev = Math.sqrt(sum(records.map((i) => Math.pow((i.rate - mean), 2))) / len);
    }
    const numberChartNames = ['statistics.descriptiveChart.name.mean', 'statistics.descriptiveChart.name.median',
      'statistics.descriptiveChart.name.standardDeviation'];
    return this.translateService.get(numberChartNames)
      .pipe(
        map(res => [
          {name: res[numberChartNames[0]], value: mean.toFixed(2)},
          {name: res[numberChartNames[1]], value: median},
          {name: res[numberChartNames[2]], value: stdDev.toFixed(2)}
        ])
      );
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
