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
  showGridLines;
  showXAxisLabel;
  xAxisLabel;
  showYAxisLabel;
  yAxisLabel;
  colorScheme;
  data;

  typeList;
  selectedTypeList;

  constructor(
    private banguminUserService: BangumiUserService
  ) {
    this.view = [500, 300];
    // options
    this.gradient = false;
    this.showLegend = true;
    this.showGridLines = true;

    this.xAxisLabel = 'Score';
    this.showXAxisLabel = true;
    this.showXAxis = true;

    this.yAxisLabel = 'Count';
    this.showYAxisLabel = true;
    this.showYAxis = true;

    this.colorScheme = {
      domain: ['#d53e4f', '#f46d43', '#fdae61', '#fee08b', '#ffffbf', '#e6f598', '#abdda4', '#66c2a5', '#3288bd', "#2361bd"]
    };

    this.typeList = ['All', 'Real', 'Anime'];
    this.selectedTypeList = [];
  }

  ngOnInit() {
    let arr = this.banguminUserService.getUserProfileStats('hi');
    this.groupAndCountByRate(arr);
  }

  switchType() {
    // value can't be exact 0 due to https://github.com/swimlane/ngx-charts/issues/498
    // tmp hack: use 0.0000001 instead
    let arr = this.banguminUserService.getUserProfileStats('hi', this.selectedTypeList);
    this.groupAndCountByRate(arr);
  }

  private groupAndCountByRate(arr) {
    // TODO: fixed xAxis ticks
    let xAxisTicks = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
    let countedArr = _.map(_.countBy(arr, "rate"), (val, key) => ({name: key, value: val}));
    let diff = _.difference(xAxisTicks, countedArr.map(t => t.name));
    if (diff.length !== 0) {
      diff.forEach((axis) => {
        countedArr.push({name: axis, value: 0.0000001});
      });
    }

    this.data = countedArr.sort(function (a, b) {
      return a.name - b.name;
    });
  }

}
