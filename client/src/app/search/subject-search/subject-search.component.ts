import {Component, Input, OnInit} from '@angular/core';
import {BangumiSearchService} from '../../shared/services/bangumi/bangumi-search.service';
import {PageState} from '../../shared/enums/page-state.enum';
import {SearchSubjectsResponseLarge} from '../../shared/models/search/search-subjects-response-large';
import {SubjectType} from '../../shared/enums/subject-type.enum';
import {CommonUtils} from '../../shared/utils/common-utils';
import {tap} from 'rxjs/operators';

@Component({
  selector: 'app-subject-search',
  templateUrl: './subject-search.component.html',
  styleUrls: ['./subject-search.component.scss']
})
export class SubjectSearchComponent implements OnInit {


  subjectSearchResults: SearchSubjectsResponseLarge;

  constructor(private bangumiSearchService: BangumiSearchService) {
  }

  private _queryKeyword: string;

  get queryKeyword() {
    return this._queryKeyword;
  }

  @Input()
  set queryKeyword(queryKeyword: string) {
    this.resetClassVariableMembers();
    this._queryKeyword = queryKeyword;
    this.performSubjectSearch(this.queryKeyword, undefined, 'large', 0, 25).subscribe();
  }

  get PageState() {
    return PageState;
  }

  ngOnInit() {
  }

  /**
   * Perform a subject search
   * @param queryKeyword keyword to search
   * @param searchFilterType
   * @param responseGroup
   * @param offset Pagination offset
   * @param limit number of results to return
   */
  performSubjectSearch(queryKeyword: string, searchFilterType = SubjectType.all, responseGroup = 'small',
                       offset = 0, limit = 25) {
    return this.bangumiSearchService.searchSubject(queryKeyword, searchFilterType, responseGroup, offset, limit).pipe(
      tap((subjectSearchResults: SearchSubjectsResponseLarge) => {
        this.subjectSearchResults = subjectSearchResults;
      }),
    );
  }

  resetClassVariableMembers() {
    this.subjectSearchResults = undefined;
  }

  // if both match have reached end of content, then infinite scroll should be disabled
  shouldDisableInfiniteScroll() {
    return false;
  }


  // current state of the page
  currentPageState() {
    if (this.queryKeyword === undefined || this.subjectSearchResults === undefined) {
      return PageState.InLoading;
    }
    return PageState.CanProceed;
  }

  getSubjectIcon(subjectType: SubjectType): string {
    return CommonUtils.getSubjectIcon(subjectType);
  }

}
