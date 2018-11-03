import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {Observable} from 'rxjs';
import {environment} from '../../../../environments/environment';
import {UserStatsSchema} from '../../models/stats/user-stats-schema';
import {SubjectStatsSchema} from '../../models/stats/subject-stats-schema';
import {TranslateService} from '@ngx-translate/core';
import {Records, RecordSchema} from '../../models/stats/record-schema';
import {map} from 'rxjs/operators';
import _meanBy from 'lodash/meanBy';
import _sortBy from 'lodash/sortBy';
import _sum from 'lodash/sum';
import _map from 'lodash/map';
import _countBy from 'lodash/countBy';
import _difference from 'lodash/difference';
import {CommonUtils} from '../../utils/common-utils';


export interface AccumulatedMeanDataSchema {
  name: string;
  series: AccumulatedMeanPoint[];
}

export interface AccumulatedMeanPoint {
  name: number | Date;
  value: number;
  count: number;
}

@Injectable({
  providedIn: 'root'
})
export class BangumiStatsService {
  static readonly colorScheme = {
    domain: ['#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00']
  };

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
   * Get count of score for a user until a specific pointTime
   * @param accumulatedMeanData Accumulated mean data
   * @param lineType Type of the line, type name is translated, for example, in user accumulated mean line chart, each line represents a
   *     subject type
   * @param pointTime Time that the point refers to on a line, score counts until this time will be returned
   */
  static getScoringCountUntil(accumulatedMeanData: AccumulatedMeanDataSchema[], lineType: string, pointTime: Date) {
    const targetAccumulatedMeanData: AccumulatedMeanDataSchema = accumulatedMeanData.find(d => d.name === lineType) ||
      {name: lineType, series: [{name: pointTime, count: 0, value: 0}]};
    return targetAccumulatedMeanData.series.find(d => d.name === pointTime).count;
  }

  /**
   * Check decimals for the percentage number(in range 0 ~100), if the current decimals are larger than {@param maxDecimals}, then format
   * it according to {@param maxDecimals}
   * @param percentage
   * @param maxDecimals
   * @param maxPrecision
   */
  static formatFloatingPoint(percentage: number, maxDecimals = 2, maxPrecision = 1) {
    return CommonUtils.getPrecision(percentage) >= maxDecimals ? Number(percentage).toFixed(maxPrecision) : percentage;
  }

  /**
   * Format date into a simple format like yyyy-mm-dd
   * @param date A date object
   */
  static formatDateToSimpleString(date: Date) {
    return date.getFullYear() + '/' + (date.getMonth() + 1) + '/' + date.getDate();
  }


  /**
   * Calculates descriptive chart data, mean, median and standard deviation are calculated and names are translated to corresponding labels
   * If rate of a record is null, it will be excluded
   * @param sortedRecords All score records, sorted by addedAt(guaranteed by server side handling)
   */
  static calculateAccumulatedMean(sortedRecords: { collectionStatus: number, addDate: number, addedAt: Date, rate: number }[]):
    AccumulatedMeanPoint[] {
    const accumulatedMeanPoints: AccumulatedMeanPoint[] = [];
    let mostRecentAddedAtMsec = 0;
    let mostRecentPoint: AccumulatedMeanPoint = {name: new Date(0), count: 0, value: 0}; // a dummy initial point
    for (let i = 0; i < sortedRecords.length; i++) {
      const currentRecord = sortedRecords[i];
      // filter invalid records(rate is null)
      if (!currentRecord.rate) {
        continue;
      }
      const mostRecentMean = mostRecentPoint.value;
      const mostRecentCount = mostRecentPoint.count;
      if (currentRecord.addDate > mostRecentAddedAtMsec) {
        mostRecentPoint = {
          name: currentRecord.addedAt,
          count: mostRecentCount + 1,
          value: (mostRecentMean * mostRecentCount + currentRecord.rate) / (mostRecentCount + 1)
        };
        accumulatedMeanPoints.push(mostRecentPoint);
        mostRecentAddedAtMsec = currentRecord.addDate;
      } else if (currentRecord.addDate === mostRecentAddedAtMsec) {
        mostRecentPoint.value = (mostRecentPoint.count * mostRecentMean + currentRecord.rate) / (mostRecentCount + 1);
        mostRecentPoint.count += 1;
      } else {
        console.error(`Invalid record ${currentRecord}`);
      }
    }
    return accumulatedMeanPoints;
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
      mean = _meanBy(records, 'rate');
      const middle = (len + 1) / 2, sorted = _sortBy(records, 'rate');
      median = (sorted.length % 2) ? sorted[middle - 1].rate : (sorted[middle - 1.5].rate + sorted[middle - 0.5].rate) / 2;
      stdDev = Math.sqrt(_sum(records.map((i) => Math.pow((i.rate - mean), 2))) / len);
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
   * Groups and counts score data by rate then return data which will be used in count bar chart
   * @param scoreVsCountData Raw score vs count data
   */
  public groupAndCountByRate(scoreVsCountData: { collectionStatus: number, addDate: string, rate: number }[])
    : { name: string, value: number }[] {
    // reject record with null rate
    const arr = scoreVsCountData.filter(stat => stat.rate);
    // TODO: fixed xAxis ticks
    const xAxisTicks = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
    let countedArr = _map(_countBy(arr, 'rate'), (val, key) => ({name: key, value: val}));
    const diff = _difference(xAxisTicks, countedArr.map(t => t.name));
    // hack fix when no data is available, show empty chart instead of all "0.00000001"
    if (diff.length === 10) {
      countedArr = [];
    } else if (diff.length !== 0) {
      diff.forEach((axis) => {
        countedArr.push({name: axis, value: 0.000001});
      });
    }

    return countedArr.sort(function (a: any, b: any) {
      return a.name - b.name;
    });
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
    (`${environment.BACKEND_API_URL}/stats/user/${userIdOrUsername}`)
      .pipe(
        map(userStats => {
          userStats.stats = Records.buildAddedAt(userStats.stats);
          return userStats;
        })
      );
  }


  /**
   * Get subject stats by Id
   * @param subjectId subject id
   */
  public getSubjectStats(subjectId: number): Observable<SubjectStatsSchema> {
    return this.http.get<SubjectStatsSchema>
    (`${environment.BACKEND_API_URL}/stats/subject/${subjectId}`)
      .pipe(
        map(subjectStats => {
          subjectStats.stats = Records.buildAddedAt(subjectStats.stats);
          return subjectStats;
        })
      );
  }
}
