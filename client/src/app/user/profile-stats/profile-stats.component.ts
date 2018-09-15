import {Component, OnInit, ViewChild, ViewEncapsulation} from '@angular/core';
import * as _ from 'lodash';
import * as day from 'dayjs';
import {filter, take} from 'rxjs/operators';
import {BanguminUserService} from '../../shared/services/bangumin/bangumin-user.service';
import {MatSelect} from '@angular/material';
import {BangumiStatsService} from '../../shared/services/bangumi/bangumi-stats.service';
import {ActivatedRoute} from '@angular/router';
import {SubjectType} from '../../shared/enums/subject-type.enum';

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

  rangeFillOpacity = 0.15;
  schemeType = 'ordinal';
  yearVsMeanData = [];
  triggerValue;

  @ViewChild('yearVsMeanSelect')
  yearVsMeanSelect: MatSelect;
  countByTypeData;

  targetUser;
  targetUserStatsArr;

  constructor(
    private banguminUserService: BanguminUserService,
    private bangumiStatsService: BangumiStatsService,
    private activatedRoute: ActivatedRoute
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
      domain: ['#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00']
    };

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

    this.activatedRoute
      .parent
      .params
      .pipe(
        filter(params => {
          this.targetUser = params['userId'];
          return this.targetUser;
        })
      )
      .subscribe(params => {
        this.bangumiStatsService.getUserStats(this.targetUser)
          .subscribe(res => {
            if (res) {
              const defaultArr = res.stats;
              // cache stats array
              this.targetUserStatsArr = res.stats;
              this.countByTypeData = _.map(_.countBy(defaultArr, 'subjectType'), (val, key) => ({name: SubjectType[key], value: val}));
              this.typeList = _.map(this.countByTypeData, 'name');

              this.initYearVsMean();
            }
          });
      });
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
    // initialize the chart with all types
    // this.selectedTypeListForyearVsMean = this.typeList;
    this.selectedTypeListForyearVsMean = ['book', 'anime'];
    const arr = this.targetUserStatsArr
      .filter((stat) => (this.selectedTypeListForyearVsMean.length === 0) ? true : this.selectedTypeListForyearVsMean.includes(SubjectType[stat.subjectType]));
    const arrByType = _.groupBy(arr, (row) => {
      return SubjectType[row.subjectType];
    });
    Object.keys(arrByType).forEach((type) => {
      this.groupAndCountByYear(arrByType[type], type);
    });

    // edit the chart on change of type selection
    // use optionSelectionChanges instead of selectionChange since we want to modify the chart minimally,
    // i.e. instead of re-filtering the whole array with selectedList, only add/remove target subjectType from the chart.
    // todo: store selectedList in observable, use pairwise() to filter out trigger value
    this.yearVsMeanSelect.optionSelectionChanges
      .subscribe(res => {
        if (res && res.isUserInput) {
          this.triggerValue = res.source.value;
          // selected a value
          if (this.selectedTypeListForyearVsMean.includes(this.triggerValue)) {
            const thisTypeArr = this.targetUserStatsArr
              .filter((stat) => (SubjectType[stat.subjectType] === this.triggerValue));
            this.groupAndCountByYear(thisTypeArr, this.triggerValue);
          } else {
            // deselected a value
            const newArr = _.filter(this.yearVsMeanData, (row) => {
              return row.name !== this.triggerValue;
            });
            this.yearVsMeanData = [...newArr];
          }
        }
      });
  }

  private getYearArr(minYear, maxYear) {
    return _.range(+minYear, (+maxYear + 1)).map((year) => ({name: year, value: 0, min: 0, max: 0}));
  }

  private groupAndCountByYear(arr, type: string) {
    const arrByYear = _.groupBy(arr, (row) => {
      return day(row.addDate).year();
    });
    const yearArr = this.getYearArr(_.min(Object.keys(arrByYear)), _.max(Object.keys(arrByYear)));
    yearArr.forEach((row) => {
      let tmpArr = arrByYear[row.name];
      if (tmpArr) {
        row.min = (_.minBy(tmpArr, 'rate')) ? +_.minBy(tmpArr, 'rate').rate : 0;
        row.max = (_.maxBy(tmpArr, 'rate')) ? +_.maxBy(tmpArr, 'rate').rate : 0;
        tmpArr = _.reject(tmpArr, (thisRow) => !thisRow.rate);
        row.value = (tmpArr.length === 0) ? 0 : _.meanBy(tmpArr, 'rate');
      }
    });
    this.yearVsMeanData = [...this.yearVsMeanData, {name: type, series: yearArr}];
  }

}
