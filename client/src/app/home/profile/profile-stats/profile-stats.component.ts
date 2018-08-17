import {Component, OnInit, ViewEncapsulation} from '@angular/core';
import * as _ from 'lodash';
import {take} from 'rxjs/operators';
import {BanguminUserService} from '../../../shared/services/bangumin/bangumin-user.service';

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
      'name': 'Cuba',
      'series': [
        {
          'value': 5544,
          'name': '2016-09-20T01:14:19.196Z',
          'min': 90,
          'max': 5801
        },
        {
          'value': 5312,
          'name': '2016-09-23T03:54:33.069Z',
          'min': 5187,
          'max': 5437
        },
        {
          'value': 2339,
          'name': '2016-09-24T00:43:23.314Z',
          'min': 2217,
          'max': 2461
        },
        {
          'value': 4854,
          'name': '2016-09-21T02:31:01.094Z',
          'min': 4481,
          'max': 5227
        },
        {
          'value': 6150,
          'name': '2016-09-14T08:44:26.704Z',
          'min': 5771,
          'max': 6529
        }
      ]
    },
    {
      'name': 'Cook Islands',
      'series': [
        {
          'value': 6953,
          'name': '2016-09-20T01:14:19.196Z',
          'min': 6662,
          'max': 7244
        },
        {
          'value': 3451,
          'name': '2016-09-23T03:54:33.069Z',
          'min': 3285,
          'max': 3617
        },
        {
          'value': 6657,
          'name': '2016-09-24T00:43:23.314Z',
          'min': 6081,
          'max': 7233
        },
        {
          'value': 4799,
          'name': '2016-09-21T02:31:01.094Z',
          'min': 4681,
          'max': 4917
        },
        {
          'value': 4218,
          'name': '2016-09-14T08:44:26.704Z',
          'min': 3992,
          'max': 4444
        }
      ]
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
    const arr = this.banguminUserService.getUserProfileStats('hi', this.selectedTypeList);
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

}
