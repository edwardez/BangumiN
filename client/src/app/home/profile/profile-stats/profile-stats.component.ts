import {Component, OnInit} from '@angular/core';
import {BangumiUserService} from "../../../shared/services/bangumi/bangumi-user.service";
import * as _ from 'lodash';

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
    let tmp = this.banguminUserService.getUserProfileStats('hi');
    this.data = _.map(_.countBy(tmp, "rate"), (val, key) => ({name: key, value: val}));
  }

  switchType(type) {
    // value can't be exact 0 due to https://github.com/swimlane/ngx-charts/issues/498
    // tmp hack: use 0.01 instead
    let arr = this.banguminUserService.getUserProfileStats('hi', type);
    this.data = _.map(_.countBy(arr, "rate"), (val, key) => ({name: key, value: val}));
  }

  private groupAndCountByRate(arr) {

  }

}
