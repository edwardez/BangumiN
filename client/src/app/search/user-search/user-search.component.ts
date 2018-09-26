import {Component, Input, OnInit} from '@angular/core';
import {PageState} from '../../shared/enums/page-state.enum';
import {BangumiSearchService} from '../../shared/services/bangumi/bangumi-search.service';
import {BanguminStyleUserBatchSearchResponse} from '../../shared/models/search/bangumin-style-batch-search-response';
import {of} from 'rxjs';
import {switchMap, tap} from 'rxjs/operators';
import {TitleService} from '../../shared/services/page/title.service';

@Component({
  selector: 'app-user-search',
  templateUrl: './user-search.component.html',
  styleUrls: ['./user-search.component.scss']
})
export class UserSearchComponent implements OnInit {

  readonly RESULTS_LIMIT_PER_QUERY = 25;
  // maximum number of offset
  readonly MAX_OFFSET_NUMBER = 200;

  userSearchResults: { fullMatch: BanguminStyleUserBatchSearchResponse, partialMatch: BanguminStyleUserBatchSearchResponse };

  endOfContent: {
    fullMatch: boolean,
    partialMatch: boolean,
  };

  visitedUserIds: Set<number>;

  constructor(private bangumiSearchService: BangumiSearchService,
              private titleService: TitleService) {
  }

  private _queryKeyword: string;

  get queryKeyword() {
    return this._queryKeyword;
  }

  @Input()
  set queryKeyword(queryKeyword: string) {
    this.resetClassVariableMembers();
    this._queryKeyword = queryKeyword;
    this.titleService.setTitleByTranslationLabel('search.user.title', {'keyword': decodeURI(this._queryKeyword)});
    this.initiateFistTimeSearch();
  }

  get PageState() {
    return PageState;
  }

  ngOnInit() {
  }

  resetClassVariableMembers() {
    this.userSearchResults = {
      fullMatch: undefined,
      partialMatch: undefined
    };
    this.endOfContent = {
      fullMatch: false,
      partialMatch: false,
    };
    this.visitedUserIds = new Set<number>();
  }

  /**
   * Perform the initial search for user
   */
  initiateFistTimeSearch() {
    this.performUserSearch(this.queryKeyword, true, 0)
      .pipe(
        switchMap(userSearchResultsToAppend => {
          // fullMatch has reached its end at the first search, perform an additional partial match search
          if (this.endOfContent.fullMatch) {
            return this.performUserSearch(this.queryKeyword, false, 0);
          }

          return of(userSearchResultsToAppend);
        })
      )
      .subscribe();
  }

  /**
   * Perform a user search, either full match or partial match will be performed depends on the {@link fullMatch} flag
   * @param queryKeyword keyword to search
   * @param fullMatch whether a full match or a partial match(ignores case) should be performed
   * @param offset Pagination offset
   * @param limit number of limit
   */
  performUserSearch(queryKeyword: string, fullMatch = false, offset = 0, limit = this.RESULTS_LIMIT_PER_QUERY) {
    const propertyToUpdate = fullMatch ? 'fullMatch' : 'partialMatch';
    return this.bangumiSearchService.searchUserByNickname(queryKeyword, fullMatch, offset, limit).pipe(
      tap(userSearchResultsToAppend => {
        userSearchResultsToAppend.rows = userSearchResultsToAppend.rows.filter(user => {
          const isVisitedUser = this.visitedUserIds.has(user.id);
          this.visitedUserIds.add(user.id);
          return !isVisitedUser;
        });

        if (this.userSearchResults[propertyToUpdate]) {
          this.userSearchResults[propertyToUpdate].rows.push(...userSearchResultsToAppend.rows);
        } else {
          this.userSearchResults[propertyToUpdate] = userSearchResultsToAppend;
        }

        if (this.userSearchResults[propertyToUpdate].rows.length >= this.userSearchResults[propertyToUpdate].count
          || this.userSearchResults[propertyToUpdate].rows.length >= this.MAX_OFFSET_NUMBER) {
          this.endOfContent[propertyToUpdate] = true;
        }
      })
    );
  }

  // if both match have reached end of content, then infinite scroll should be disabled
  shouldDisableInfiniteScroll() {
    return this.endOfContent.fullMatch && this.endOfContent.partialMatch;
  }

  // on scroll down, perform a search, full match will always be performed first
  onScrollDown() {
    if (!this.endOfContent.fullMatch) {
      this.performUserSearch(this.queryKeyword, true, this.userSearchResults.fullMatch.rows.length)
        .subscribe(result => {
          if (this.endOfContent.fullMatch) {
            return this.performUserSearch(this.queryKeyword, false, 0).subscribe();
          }
        });
    } else if (!this.endOfContent.partialMatch) {
      this.performUserSearch(this.queryKeyword, false, this.userSearchResults.partialMatch.rows.length)
        .subscribe();
    }

  }

  // current state of the page
  currentPageState() {
    if (this.queryKeyword === undefined || this.userSearchResults === undefined || this.userSearchResults.fullMatch === undefined) {
      return PageState.InLoading;
    }
    return PageState.CanProceed;
  }


}
