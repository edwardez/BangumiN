import {Component, ElementRef, OnInit, ViewChild} from '@angular/core';
import {ActivatedRoute, Router} from '@angular/router';
import {filter} from 'rxjs/operators';
import {SearchBarAutoCompleteDefaultOptions, SearchBarAutoCompleteOptionValue, SearchBy, SearchIn} from '../../shared/enums/search-configs';


@Component({
  selector: 'app-nav-search-bar',
  templateUrl: './nav-search-bar.component.html',
  styleUrls: ['./nav-search-bar.component.scss']
})
export class NavSearchBarComponent implements OnInit {

  searchKeywords = '';

  availableSearchMethods: SearchBarAutoCompleteDefaultOptions[] = [
    {
      'searchIn': SearchIn.subject,
      'searchBy': SearchBy.keyword,
      'translationLabel': 'nav.search.autocomplete.searchKeywordInSubject'
    },
    {
      'searchIn': SearchIn.user,
      'searchBy': SearchBy.keyword,
      'translationLabel': 'nav.search.autocomplete.searchKeywordInUser'
    },
    {
      'searchIn': SearchIn.subject,
      'searchBy': SearchBy.id,
      'translationLabel': 'nav.search.autocomplete.jumpToSubjectId'
    },
    {
      'searchIn': SearchIn.user,
      'searchBy': SearchBy.id,
      'translationLabel': 'nav.search.autocomplete.jumpToUserId'
    }
  ];

  @ViewChild('searchBar')
  searchBarInput: ElementRef;

  constructor(
    private activatedRoute: ActivatedRoute,
    private router: Router) {
  }

  get SearchBy() {
    return SearchBy;
  }

  ngOnInit() {
    this.updateSearchBarText();
  }

  onAutoCompleteOptionSelected(event) {
    const autoCompleteOptionValue = event.option.value as SearchBarAutoCompleteOptionValue;
    const searchType = autoCompleteOptionValue.extraInfo;
    this.searchBarInput.nativeElement.value = autoCompleteOptionValue.inputValue;

    switch (true) {
      case (searchType.searchIn === SearchIn.subject && searchType.searchBy === SearchBy.keyword):
        this.searchSubjectWithKeyword(autoCompleteOptionValue.inputValue);
        break;
      case (searchType.searchIn === SearchIn.user && searchType.searchBy === SearchBy.keyword):
        this.searchUserWithKeyword(autoCompleteOptionValue.inputValue);
        break;
      case (searchType.searchIn === SearchIn.subject && searchType.searchBy === SearchBy.id):
        this.navigateToSpecifiedSubjectId(autoCompleteOptionValue.inputValue);
        break;
      case (searchType.searchIn === SearchIn.user && searchType.searchBy === SearchBy.id):
        this.navigateToSpecifiedUserId(autoCompleteOptionValue.inputValue);
        break;
    }
  }

  searchSubjectWithKeyword(keyword: string) {
    this.router.navigate(['/search'], {queryParams: {query: encodeURI(keyword), type: SearchIn.subject}});
  }

  searchUserWithKeyword(keyword: string) {
    this.router.navigate(['/search'], {queryParams: {query: encodeURI(keyword), type: SearchIn.user}});
  }

  navigateToSpecifiedSubjectId(id: string) {
    this.router.navigate(['/subject', (id || '1').replace(/ /g, '')]);
  }

  navigateToSpecifiedUserId(id: string) {
    this.router.navigate(['/user', (id || '1').replace(/ /g, ''), 'statistics']);
  }

  /**
   * this function will update text in search bar according to route params
   */
  updateSearchBarText() {
    this.activatedRoute
      .queryParams
      .pipe(
        filter(params => params['query'] !== undefined)
      ).subscribe(
      params => {
        this.searchKeywords = decodeURI(params['query']);
        this.searchBarInput.nativeElement.value = this.searchKeywords;
      }
    );
  }

  /**
   * Filter autocomplete options according to user input
   * @param option search option
   * @param searchValue User-entered search value
   */
  shouldShowCurrentAutoCompleteOption(option: SearchBarAutoCompleteDefaultOptions, searchValue: string) {
    const trimmedSearchValue = (searchValue || '').replace(/ /g, '');
    if (option.searchIn === SearchIn.subject && option.searchBy === SearchBy.id) {
      // subject id must be pure digits, cannot be 0
      // for testing 0, use string equal since it's faster https://jsperf.com/regex-or-vs-string-equals/8
      return RegExp(/^\d+$|^[^0]$/).test(trimmedSearchValue) && trimmedSearchValue !== '0';
    }

    if (option.searchIn === SearchIn.user && option.searchBy === SearchBy.id) {
      // user id must be pure alphanum
      // for testing 0, use string equal since it's faster https://jsperf.com/regex-or-vs-string-equals/8
      return RegExp(/^[a-zA-Z0-9]*$/).test(trimmedSearchValue) && trimmedSearchValue !== '0';
    }

    return true;
  }

}
