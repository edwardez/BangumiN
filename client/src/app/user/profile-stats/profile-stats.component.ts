import {Component, OnInit, ViewChild, ViewEncapsulation} from '@angular/core';
import * as _ from 'lodash';
import * as day from 'dayjs';
import {take} from 'rxjs/operators';
import {BanguminUserService} from '../../shared/services/bangumin/bangumin-user.service';
import {MatSelect} from '@angular/material';

@Component({
  selector: 'app-profile-stats',
  templateUrl: './profile-stats.component.html',
  styleUrls: ['./profile-stats.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class ProfileStatsComponent implements OnInit {
  view;
  showXAxis;
  showYAxis;
  gradient;
  showLegend;
  showGridLines;
  showXAxisLabel;
  xAxisLabel;
  showYAxisLabel;
  yAxisLabel;
  colorScheme;
  scoreVsCountData;
  theme;

  typeList;
  selectedTypeListForscoreVsCount;
  selectedTypeListForyearVsMean;

  rangeFillOpacity = 0.15;
  schemeType = 'ordinal';
  yearVsMeanData = [];

  @ViewChild('select')
  select: MatSelect;
  lastValue;

  constructor(
    private banguminUserService: BanguminUserService
  ) {
    this.view = [500, 300];
    // options
    this.gradient = false;
    this.showLegend = true;
    this.showGridLines = true;
    // todo: translate legend and label
    this.xAxisLabel = 'Score';
    this.showXAxisLabel = true;
    this.showXAxis = true;

    this.yAxisLabel = 'Count';
    this.showYAxisLabel = true;
    this.showYAxis = true;

    this.colorScheme = {
      domain: ['#d53e4f', '#f46d43', '#fdae61', '#fee08b', '#ffffbf', '#e6f598', '#abdda4', '#66c2a5', '#3288bd', '#2361bd']
    };

    this.typeList = ['Real', 'Anime'];
    this.selectedTypeListForscoreVsCount = this.typeList;
    this.selectedTypeListForyearVsMean = this.typeList;
  }

  ngOnInit() {
    this.banguminUserService.getUserSettings()
      .pipe(
        take(1)
      ).subscribe(settings => {
      if (settings && settings.appTheme === 'bangumin-material-dark-pink-blue-grey') {
        this.theme = 'dark';
      }
    });
    this.inityearVsMean();
  }

  switchType(target, graph: string) {
    // value can't be exact 0 due to https://github.com/swimlane/ngx-charts/issues/498
    // tmp hack: use 0.0000001 instead
    if (graph === 'scoreVsCount') {
      const arr = this.banguminUserService.getUserProfileStats('hi')
        .filter((stat) => (this.selectedTypeListForscoreVsCount.length === 0) ? true : this.selectedTypeListForscoreVsCount.includes(stat.typ));
      this.groupAndCountByRate(arr);
    } else if (graph === 'yearVsMean') {
      console.log('lastValue', this.lastValue);
      const arr = this.banguminUserService.getUserProfileStats('hi')
        .filter((stat) => (this.selectedTypeListForyearVsMean.length === 0) ? true : this.selectedTypeListForyearVsMean.includes(stat.typ));
      this.groupAndCountByYear(arr);
    }

  }

  calendarAxisTickFormatting(year: string) {
    return day().set('year', +year).year();
  }

  private inityearVsMean() {
    this.yearVsMeanData.push({
      'name': '',
      'series': []
    });
    this.select.optionSelectionChanges
      .subscribe((res) => {
        if (res) {
          this.lastValue = res.source.value;
        }
      );
  }

  private groupAndCountByRate(arr) {
    // TODO: fixed xAxis ticks
    const xAxisTicks = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
    const countedArr = _.map(_.countBy(arr, 'rate'), (val, key) => ({name: key, value: val}));
    const diff = _.difference(xAxisTicks, countedArr.map(t => t.name));
    if (diff.length !== 0) {
      diff.forEach((axis) => {
        countedArr.push({name: axis, value: 0.000001});
      });
    }

    this.scoreVsCountData = countedArr.sort(function (a: any, b: any) {
      return a.name - b.name;
    });
  }

  private groupAndCountByYear(arr) {
    const arrByYear = _.groupBy(arr, (row) => {
      return day(row.adddate).year();
    });
    const yearArr = this.getYearArr(_.min(Object.keys(arrByYear)), _.max(Object.keys(arrByYear)));
    yearArr.forEach((row) => {
      const tmpArr = arrByYear[row.name];
      if (tmpArr) {
        row.min = +_.minBy(tmpArr, 'rate').rate;
        row.max = +_.maxBy(tmpArr, 'rate').rate;
        row.value = +_.meanBy(tmpArr, 'rate');
      }
    });
    this.yearVsMeanData = [{name: 'Anime', series: yearArr}];
  }

  private getYearArr(minYear, maxYear) {
    return _.range(+minYear, (+maxYear + 1)).map((year) => ({name: year.toString(), value: 0, min: 0, max: 0}));
  }

}
