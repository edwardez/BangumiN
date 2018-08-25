import {Component, OnInit, ViewEncapsulation} from '@angular/core';
import * as _ from 'lodash';
import * as moment from 'moment';
import {take} from 'rxjs/operators';
import {BanguminUserService} from '../../shared/services/bangumin/bangumin-user.service';

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
  data;
  theme;

  typeList;
  selectedTypeList;

  rangeFillOpacity = 0.15;
  schemeType = 'ordinal';
  lineData = [
    {
      'name': '',
      'series': []
    }
  ];

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
    this.selectedTypeList = this.typeList;
  }

  ngOnInit() {
    const arr = this.banguminUserService.getUserProfileStats('hi');
    this.groupAndCountByRate(arr);

    this.banguminUserService.getUserSettings()
      .pipe(
        take(1)
      ).subscribe(settings => {
      if (settings && settings.appTheme === 'bangumin-material-dark-pink-blue-grey') {
        this.theme = 'dark';
      }
    });
  }

  switchType() {
    // value can't be exact 0 due to https://github.com/swimlane/ngx-charts/issues/498
    // tmp hack: use 0.0000001 instead
    const arr = this.banguminUserService.getUserProfileStats('hi')
      .filter((stat) => (this.selectedTypeList.length === 0) ? true : this.selectedTypeList.includes(stat.typ));
    this.groupAndCountByRate(arr);
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

    this.data = countedArr.sort(function (a: any, b: any) {
      return a.name - b.name;
    });
  }

  private groupAndCountByYear() {
    const arr = this.banguminUserService.getUserProfileStats('hi');
    const arrByYear = _.groupBy(arr, (row) => {
      return moment(row.adddate).year();
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
    this.lineData = [{name: 'Anime', series: yearArr}];
  }

  private getYearArr(minYear, maxYear) {
    const arr = _.range(+minYear, (+maxYear + 1)).map((year) => ({name: year, value: 0, min: 0, max: 0}));
    return arr.slice();
  }

  public calendarAxisTickFormatting(year: string) {
    return moment(year).year();
  }

}
