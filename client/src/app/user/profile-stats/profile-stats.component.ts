import {Component, OnInit, ViewChild, ViewEncapsulation} from '@angular/core';
import * as _ from 'lodash';
import * as day from 'dayjs';
import {flatMap, take} from 'rxjs/operators';
import {BanguminUserService} from '../../shared/services/bangumin/bangumin-user.service';
import {MatSelect} from '@angular/material';
import {of} from 'rxjs';

@Component({
  selector: 'app-profile-stats',
  templateUrl: './profile-stats.component.html',
  styleUrls: ['./profile-stats.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class ProfileStatsComponent implements OnInit {
  // todo: options for each chart
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
  selectedTypeListForDefault;

  rangeFillOpacity = 0.15;
  schemeType = 'ordinal';
  yearVsMeanData = [];
  triggerValue;

  @ViewChild('yearVsMeanSelect')
  yearVsMeanSelect: MatSelect;
  countByTypeData;

  constructor(
    private banguminUserService: BanguminUserService
  ) {
    this.view = [800, 500];
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

    this.typeList = ['real', 'anime', 'game', 'book'];
    this.selectedTypeListForscoreVsCount = this.typeList;
    this.selectedTypeListForyearVsMean = this.typeList;
    this.selectedTypeListForDefault = this.typeList;
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
    this.initYearVsMean();
    // initialize default pie-chart view
    // this.banguminUserService.getUserProfileStats('hi')
    //   .subscribe((res) => {
    //     if (res) {
    //       const defaultArr = res
    //         .filter((stat) => (this.selectedTypeListForDefault.length === 0) ? true : this.selectedTypeListForDefault.includes(stat.typ));
    //       this.countByTypeData = _.map(_.countBy(defaultArr, 'typ'), (val, key) => ({name: key, value: val}));
    //     }
    //   });
  }

  switchType(graph: string) {
    // value can't be exact 0 due to https://github.com/swimlane/ngx-charts/issues/498
    // tmp hack: use 0.0000001 instead
    if (graph === 'scoreVsCount') {
      this.banguminUserService.getUserProfileStats('hi')
        .subscribe((res) => {
          if (res) {
            const arr = res
              .filter((stat) => {
                if (this.selectedTypeListForscoreVsCount.length === 0) {
                  return true;
                } else {
                  return this.selectedTypeListForscoreVsCount.includes(stat.typ);
                }
              });
            this.groupAndCountByRate(arr);
          }
        });
    }
  }

  calendarAxisTickFormatting(year) {
    if (Math.floor(year) !== year) {
      return '';
    }
    return day().set('year', year).year();
  }

  pieTooltipText({data}) {
    const label = data.name;
    const val = data.value;

    return `
      <span class="tooltip-label">${label}</span>
      <span class="tooltip-val">${val}</span>
    `;
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

  private initYearVsMean() {
    // todo: how to initialize the chart?
    // this.yearVsMeanData.push({
    //   'name': '',
    //   'series': []
    // });
    // initialize the chart with all types
    this.banguminUserService.getUserProfileStats('hi')
      .subscribe((res) => {
        if (res) {
          const arr = res
            .filter((stat) => (this.selectedTypeListForyearVsMean.length === 0) ? true : this.selectedTypeListForyearVsMean.includes(stat.typ));
          const arrByType = _.groupBy(arr, (row) => {
            return row.typ;
          });
          Object.keys(arrByType).forEach((type) => {
            this.groupAndCountByYear(arrByType[type], type);
          });
        }
      });

    // edit the chart on change of type selection
    this.yearVsMeanSelect.optionSelectionChanges
      .pipe(
        flatMap((res) => {
          if (res && res.isUserInput) {
            this.triggerValue = res.source.value;
            // selected a value
            if (this.selectedTypeListForyearVsMean.includes(this.triggerValue)) {
              return this.banguminUserService.getUserProfileStats('hi');
            } else {
              // deselected a value
              const newArr = _.filter(this.yearVsMeanData, (row) => {
                return row.name !== this.triggerValue;
              });
              this.yearVsMeanData = [...newArr];
            }
            return of();
          }
        })
      ).subscribe((res: [any]) => {
      if (res) {
        const thisTypeArr = res.filter((stat) => (stat.typ === this.triggerValue));
        this.groupAndCountByYear(thisTypeArr, this.triggerValue);
        }
    });
  }

  private getYearArr(minYear, maxYear) {
    return _.range(+minYear, (+maxYear + 1)).map((year) => ({name: year, value: 0, min: 0, max: 0}));
  }

  private groupAndCountByYear(arr, type: string) {
    const arrByYear = _.groupBy(arr, (row) => {
      return day(row.adddate).year();
    });
    const yearArr = this.getYearArr(_.min(Object.keys(arrByYear)), _.max(Object.keys(arrByYear)));
    yearArr.forEach((row) => {
      const tmpArr = arrByYear[row.name];
      if (tmpArr) {
        row.min = (_.minBy(tmpArr, 'rate')) ? +_.minBy(tmpArr, 'rate').rate : 0;
        row.max = (_.maxBy(tmpArr, 'rate')) ? +_.maxBy(tmpArr, 'rate').rate : 0;
        row.value = _(tmpArr)
                      .reject((row) => !row.rate)
                      .meanBy('rate');
      }
    });
    this.yearVsMeanData = [...this.yearVsMeanData, {name: type, series: yearArr}];
  }

}
