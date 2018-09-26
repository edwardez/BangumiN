import {Component, OnInit} from '@angular/core';
import {ActivatedRoute} from '@angular/router';
import {SearchIn} from '../../shared/enums/search-configs';
import {PageState} from '../../shared/enums/page-state.enum';

@Component({
  selector: 'app-search-result',
  templateUrl: './search-result.component.html',
  styleUrls: ['./search-result.component.scss']
})
export class SearchResultComponent implements OnInit {
  selectedSearchType: SearchIn;
  queryKeyword: string;

  constructor(private activatedRoute: ActivatedRoute) {
  }

  get SearchIn() {
    return SearchIn;
  }

  get PageState() {
    return PageState;
  }

  ngOnInit() {
    this.initSearchComponent();
  }

  initSearchComponent() {
    this.activatedRoute
      .queryParams
      .subscribe((searchConfig: { query: string, type: string }) => {
        this.queryKeyword = searchConfig.query;
        if (searchConfig.type === SearchIn.subject.toString()) {
          this.selectedSearchType = SearchIn.subject;
        } else if (searchConfig.type === SearchIn.user.toString()) {
          this.selectedSearchType = SearchIn.user;
        } else {
          // else, by default searching in user
          this.selectedSearchType = SearchIn.user;
        }
      });
  }

  currentPageState() {
    if (this.queryKeyword === undefined) {
      return PageState.InLoading;
    } else if (this.queryKeyword !== undefined && !this.queryKeyword) {
      return PageState.IsInvalidQuery;
    }
    return PageState.CanProceed;
  }

}
