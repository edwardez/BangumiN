import {Component, Input, OnDestroy, OnInit} from '@angular/core';
import {BangumiSearchService} from '../../shared/services/bangumi/bangumi-search.service';
import {PageState} from '../../shared/enums/page-state.enum';
import {SearchSubjectsResponseLarge} from '../../shared/models/search/search-subjects-response-large';
import {SubjectType} from '../../shared/enums/subject-type.enum';
import {CommonUtils} from '../../shared/utils/common-utils';
import {takeUntil, tap} from 'rxjs/operators';
import {FormBuilder, FormGroup} from '@angular/forms';
import {Subject} from 'rxjs';

@Component({
  selector: 'app-subject-search',
  templateUrl: './subject-search.component.html',
  styleUrls: ['./subject-search.component.scss']
})
export class SubjectSearchComponent implements OnInit, OnDestroy {

  readonly PER_QUERY_COUNT_LIMIT = 15;
  disableInfiniteScroll = false;
  searchedTimes = 0;
  visitedSubjectIds: Set<number>;
  subjectSearchFilterForm: FormGroup;
  private ngUnsubscribe: Subject<void> = new Subject<void>();
  subjectSearchResults: SearchSubjectsResponseLarge;

  constructor(private bangumiSearchService: BangumiSearchService,
              private formBuilder: FormBuilder,) {
    this.initializeSubjectSearchFilterForm();
  }

  private _queryKeyword: string;

  get queryKeyword() {
    return this._queryKeyword;
  }

  @Input()
  set queryKeyword(queryKeyword: string) {
    this.resetClassVariableMembers();
    this._queryKeyword = queryKeyword;
    this.performSubjectSearch(this.queryKeyword, this.subjectSearchFilterForm.get('subjectTypeFilter').value, 'large', 0,
      this.PER_QUERY_COUNT_LIMIT).subscribe();
  }

  get PageState() {
    return PageState;
  }

  get subjectTypeFilter() {
    return this.subjectSearchFilterForm.get('subjectTypeFilter');
  }

  ngOnInit() {
  }

  initializeSubjectSearchFilterForm() {
    this.subjectSearchFilterForm = this.formBuilder.group(
      {
        'subjectTypeFilter': [SubjectType.all],
      }
    );
    this.subjectSearchFilterForm.get('subjectTypeFilter').valueChanges
      .pipe(
        takeUntil(this.ngUnsubscribe)
      )
      .subscribe(newSubjectFilter => {
        this.resetClassVariableMembers();
        this.performSubjectSearch(this.queryKeyword, newSubjectFilter, 'large', 0,
          this.PER_QUERY_COUNT_LIMIT).subscribe();
      });
  }

  /**
   * Perform a subject search
   * Known issue: due to limitation of infinite scroll and the Bangumi search API, same search might be performed twice, needs to
   * figure out a way to fix this
   * @param queryKeyword keyword to search
   * @param searchFilterType
   * @param responseGroup
   * @param offset Pagination offset
   * @param limit number of results to return
   */
  performSubjectSearch(queryKeyword: string, searchFilterType = SubjectType.all, responseGroup = 'small',
                       offset = 0, limit = 25) {
    this.searchedTimes++;
    return this.bangumiSearchService.searchSubject(queryKeyword, searchFilterType, responseGroup, offset, limit).pipe(
      tap((subjectSearchResults: SearchSubjectsResponseLarge) => {
        subjectSearchResults.subjects = subjectSearchResults.subjects.filter(subject => {
          const isVisitedSubject = this.visitedSubjectIds.has(subject.id);
          this.visitedSubjectIds.add(subject.id);
          return !isVisitedSubject;
        });

        if (this.subjectSearchResults) {
          this.subjectSearchResults.subjects.push(...subjectSearchResults.subjects);
        } else {
          this.subjectSearchResults = subjectSearchResults;
        }
        if (this.searchedTimes * this.PER_QUERY_COUNT_LIMIT >= this.subjectSearchResults.count) {
          this.disableInfiniteScroll = true;
        }

      }),
    );
  }

  resetClassVariableMembers() {
    this.subjectSearchResults = undefined;
    this.searchedTimes = 0;
    this.visitedSubjectIds = new Set<number>();
    this.disableInfiniteScroll = false;
    // scroll to the top
    window.scrollTo(0, 0);
  }

  onScrollDown() {
    this.performSubjectSearch(this.queryKeyword, this.subjectSearchFilterForm.get('subjectTypeFilter').value, 'large',
      this.searchedTimes * this.PER_QUERY_COUNT_LIMIT,
      this.PER_QUERY_COUNT_LIMIT).subscribe();
  }


  // current state of the page
  currentPageState() {
    if (this.queryKeyword === undefined || this.subjectSearchResults === undefined) {
      return PageState.InLoading;
    }
    return PageState.CanProceed;
  }

  getAllSubjectTypes(): number[] {
    return Object.keys(SubjectType).map(k => SubjectType[k]).filter(v => typeof v === 'number');
  }

  getSubjectIcon(subjectType: SubjectType): string {
    return CommonUtils.getSubjectIcon(subjectType);
  }

  getSubjectTypeName(subjectType: SubjectType): string {
    return CommonUtils.getSubjectTypeName(subjectType);
  }

  ngOnDestroy(): void {
    console.log('sss');
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

}
