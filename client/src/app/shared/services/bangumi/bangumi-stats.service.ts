import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {Observable} from 'rxjs';
import {environment} from '../../../../environments/environment';
import {UserStatsSchema} from '../../models/stats/user-stats-schema';
import {SubjectStatsSchema} from '../../models/stats/subject-stats-schema';
import {TranslateService} from '@ngx-translate/core';
import {RecordSchema} from '../../models/stats/record-schema';
import {map} from 'rxjs/operators';
import _meanBy from 'lodash/meanBy';
import _sortBy from 'lodash/sortBy';
import _sum from 'lodash/sum';
import _map from 'lodash/map';
import _countBy from 'lodash/countBy';
import _difference from 'lodash/difference';
import _groupBy from 'lodash/groupBy';
import _min from 'lodash/min';
import _range from 'lodash/range';
import _isEmpty from 'lodash/isEmpty';


export interface AccumulatedMeanDataSchema {
  name: string;
  series: AccumulatedMeanPoint[];
}

export interface AccumulatedMeanPoint {
  name: number;
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
  static getScoringCountUntil(accumulatedMeanData: AccumulatedMeanDataSchema[], lineType: string, pointTime: number) {
    const targetAccumulatedMeanData: AccumulatedMeanDataSchema = accumulatedMeanData.find(d => d.name === lineType) ||
      {name: lineType, series: [{name: pointTime, count: 0, value: 0}]};
    return targetAccumulatedMeanData.series.find(d => d.name === pointTime).count;
  }

  /**
   * Initialize an array which contains name, value and count from the minYear to maxYear
   * i.e. [{name: 2010, value: 0, count: 0}, {name: 2011, value: 0, count: 0}]
   * @param minYear Start point of year
   * @param maxYear End point of year
   */
  static initAccumulatedMeanByYear(minYear: number, maxYear: number): AccumulatedMeanPoint[] {
    return _range(+minYear, (+maxYear + 1)).map((year) => ({name: year, value: 0, count: 0}));
  }

  /**
   * Calculates descriptive chart data, mean, median and standard deviation are calculated and names are translated to corresponding labels
   * If rate of a record is null, it will be excluded
   * @param allRecords All score records
   */
  static calculateAccumulatedMean(allRecords: { collectionStatus: number, addDate: string, rate: number }[]): AccumulatedMeanPoint[] {
    const accumulatedCountByYear = {};
    const recordsByYear = _groupBy(
      allRecords.filter(record => record.rate),
      (row) => {
        return new Date(row.addDate).getFullYear();
      });
    // is there's no record after filtering, return empty array
    if (_isEmpty(recordsByYear)) {
      return [];
    }
    const accumulatedMeanByYear = BangumiStatsService.initAccumulatedMeanByYear(+_min(Object.keys(recordsByYear)),
      new Date().getFullYear());
    accumulatedMeanByYear.forEach(row => {
      const currentYear = row.name;
      // have to consider year with no data, since we are storing accumulated data
      const recordsInCurrentYear = recordsByYear[currentYear] || [];
      // note down the yearAccumulated Count
      accumulatedCountByYear[currentYear] = (accumulatedCountByYear[currentYear - 1] || 0) + recordsInCurrentYear.length;
      const currentMean = (recordsInCurrentYear.length === 0) ? 0 : _meanBy(recordsInCurrentYear, 'rate');
      const lastYearData = accumulatedMeanByYear.filter(currentMeanData => currentMeanData.name === (currentYear - 1))[0];
      const meanUntilLastYear = lastYearData ? lastYearData.value : 0;
      const countsUntilLastYear = accumulatedCountByYear[currentYear - 1] || 0;
      const countsUntilCurrentYear = recordsInCurrentYear.length + countsUntilLastYear;
      row.value = countsUntilCurrentYear ?
        ((currentMean * recordsInCurrentYear.length
          + countsUntilLastYear * meanUntilLastYear) / countsUntilCurrentYear) : 0;
      row.count = accumulatedCountByYear[currentYear];
    });
    return accumulatedMeanByYear;
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
