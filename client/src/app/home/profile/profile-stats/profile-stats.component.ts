import {Component, OnInit} from '@angular/core';
import {BangumiUserService} from "../../../shared/services/bangumi/bangumi-user.service";

@Component({
  selector: 'app-profile-stats',
  templateUrl: './profile-stats.component.html',
  styleUrls: ['./profile-stats.component.scss']
})
export class ProfileStatsComponent implements OnInit {
  view;
  showXAxis;
  showYAxis;
  gradient;
  showLegend;
  showXAxisLabel;
  xAxisLabel;
  showYAxisLabel;
  yAxisLabel;
  colorScheme;
  data;

  constructor(
    private banguminUserService: BangumiUserService
  ) {
    this.view = [700, 400];
    // options
    this.gradient = false;
    this.showLegend = true;

    this.xAxisLabel = 'Score';
    this.showXAxisLabel = true;
    this.showXAxis = true;

    this.yAxisLabel = 'Count';
    this.showYAxisLabel = true;
    this.showYAxis = false;

    this.colorScheme = {
      domain: ['#d53e4f', '#f46d43', '#fdae61', '#fee08b', '#ffffbf', '#e6f598', '#abdda4', '#66c2a5', '#3288bd', "#2361bd"]
    };
  }

  ngOnInit() {
    this.data = [
      {
        'name': '1',
        'value': 10
      }, {
        'name': '2',
        'value': 3
      }, {
        'name': '3',
        'value': 4
      }, {
        'name': '4',
        'value': 0.01
      }, {
        'name': '5',
        'value': 1
      }, {
        'name': '6',
        'value': 12
      }, {
        'name': '7',
        'value': 17
      }, {
        'name': '8',
        'value': 4
      }, {
        'name': '9',
        'value': 11
      }, {
        'name': '10',
        'value': 1
      }
    ];

    let tmp = this.banguminUserService.getUserProfileStats('hi');
  }

  switchType(type) {
    // value can't be exact 0 due to https://github.com/swimlane/ngx-charts/issues/498
    // tmp hack: use 0.01 instead
    if (type === 'Real') {
      this.data = [
        {
          'name': '1',
          'value': 1
        }, {
          'name': '2',
          'value': 4
        }, {
          'name': '3',
          'value': 14
        }, {
          'name': '4',
          'value': 1
        }, {
          'name': '5',
          'value': 13
        }, {
          'name': '6',
          'value': 23
        }, {
          'name': '7',
          'value': 12
        }, {
          'name': '8',
          'value': 4
        }, {
          'name': '9',
          'value': 8
        }, {
          'name': '10',
          'value': 5
        }
      ];
    }
  }

}
