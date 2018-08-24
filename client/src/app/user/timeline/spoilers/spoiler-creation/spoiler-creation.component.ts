import {Component, ElementRef, OnInit, ViewChild} from '@angular/core';
import {AuthenticationService} from '../../../../shared/services/auth.service';
import {catchError, finalize, map} from 'rxjs/operators';
import {BangumiUser} from '../../../../shared/models/BangumiUser';

import Quill from 'quill';
import {MatAutocompleteSelectedEvent, MatAutocompleteTrigger} from '@angular/material';
import {FormArray, FormBuilder, FormGroup, Validators} from '@angular/forms';
import {Observable, of, throwError} from 'rxjs';
import {BangumiSearchService} from '../../../../shared/services/bangumi/bangumi-search.service';
import {SubjectBase} from '../../../../shared/models/subject/subject-base';
import {SearchSubjectsResponseSmall} from '../../../../shared/models/search/search-subjects-response-small';
import {SubjectType} from '../../../../shared/enums/subject-type.enum';

const Parchment = Quill.import('parchment');

class SpoilerClass extends Parchment.Attributor.Class {
  constructor(attrName = 'spoiler', keyName = 'background-color-bangumin-theme-accent') {
    super(attrName, keyName, {scope: Parchment.Scope.INLINE});
  }

  add(node, value) {
    if (!this.canAdd(node, value)) {
      return false;
    }
    node.classList.add(`background-color-bangumin-theme-accent`);
    node.classList.add(`spoiler-text`);
    node.classList.add(`color-bangumin-theme-foreground`);
    return true;
  }

  remove(node, id) {
    node.classList.remove(`background-color-bangumin-theme-accent`);
    node.classList.remove(`spoiler-text`);
    node.classList.remove(`color-bangumin-theme-foreground`);
    if (node.classList.length === 0) {
      node.removeAttribute('class');
    }
  }

  value(node) {
    return true;
  }
}

export class SubjectSearchConfig {
  // expect user to tolerate a shorter timeout period here
  static readonly SEARCH_TIME_OUT = 3000;
  static readonly MAX_SEARCH_RESULT = 10;
  // user can only add up to this number of related subjects
  static readonly MAXIMUM_RELATED_SUBJECT_NUMBER = 2;
}
@Component({
  selector: 'app-spoiler-creation',
  templateUrl: './spoiler-creation.component.html',
  styleUrls: ['./spoiler-creation.component.scss']
})
export class SpoilerCreationComponent implements OnInit {

  bangumiUser: BangumiUser;
  spoilerEditor: Quill;

  disableSearch = false;
  spoilerForm: FormGroup;
  subjectSearchResult: Observable<SubjectBase[]>;
  subjects: string[] = [];


  @ViewChild('subjectInput')
  subjectInput: ElementRef;

  @ViewChild('matAutocompleteTrigger')
  matAutocompleteTrigger: MatAutocompleteTrigger;

  constructor(private authenticationService: AuthenticationService,
              private bangumiSearchService: BangumiSearchService,
              private formBuilder: FormBuilder
  ) {
  }

  static generateSubjectSearchResult(searchKeyWord: string, searchSubjectsResponse?: SearchSubjectsResponseSmall):
    SearchSubjectsResponseSmall {
    let searchResult;
    if (!searchSubjectsResponse) {
      searchResult = new SearchSubjectsResponseSmall();
    } else {
      searchResult = searchSubjectsResponse;
    }

    searchResult.subjects.push(SpoilerCreationComponent.getDefaultEmptySubject(searchKeyWord));

    return searchResult;
  }

  static getDefaultEmptySubject(searchKeyWord: string): SubjectBase {
    // use secondary name as the place to place prompt text
    return new SubjectBase(
      undefined, undefined, undefined, searchKeyWord,
      'profile.tabs.timeline.spoilerBox.creation.dialog.option.tagSubject.searchResult.noResult',
      undefined, undefined, undefined, undefined);
  }

  ngOnInit() {
    this.subjectSearchResult = of([]);
    Quill.register(new SpoilerClass(), true);
    const icons = Quill.import('ui/icons');
    icons['clean'] = '<mat-icon class="mat-icon material-icons">visibility</mat-icon>';

    this.initializeSpoilerForm();
  }

  initializeEditor(quill: Quill) {
    this.spoilerEditor = quill;
  }

  initializeSpoilerForm() {
    this.spoilerForm = this.formBuilder.group(
      {
        spoilerText: ['', Validators.maxLength(20)],
        relatedSubjects: this.formBuilder.array([], Validators.maxLength(10))
      }
    );
  }

  markSpoilerText(event) {
    this.spoilerEditor.format('spoiler', true);
  }

  // perform a new subject search and attach a user-defined subject, currently this will be called if user clicks search or presses enter
  onTriggerSubjectSearch(event) {
    const searchKeyWord = this.subjectInput.nativeElement.value;
    // if search is currently disabled or search keyword is empty, do nothing and return
    if (this.disableSearch || !searchKeyWord) {
      return;
    }
    event.stopPropagation();
    this.disableSearch = true;
    this.updateSearchButtonText();
    this.subjectSearchResult = this.bangumiSearchService.searchSubject(searchKeyWord,
      undefined, 'small', undefined, SubjectSearchConfig.MAX_SEARCH_RESULT, SubjectSearchConfig.SEARCH_TIME_OUT).pipe(
      map(searchResult => {
        return SpoilerCreationComponent.generateSubjectSearchResult(searchKeyWord, searchResult).subjects;
      }),
      catchError((error) => {
        return throwError(error);
      }),
      finalize(() => {
          this.updateSearchButtonText();
          // anyhow, reset the search button so user can perform next search
          this.disableSearch = false;
        }
      )
    );
  }

  onSearchAutoCompleteOptionSelect(event: MatAutocompleteSelectedEvent): void {
    const selectedSubject: SubjectBase = <SubjectBase>event.option.value;
    this.subjects.push(selectedSubject.subjectName.preferred);
    this.subjectInput.nativeElement.value = '';
    const relatedSubjects = this.spoilerForm.get('relatedSubjects') as FormArray;
    relatedSubjects.push(this.formBuilder.control({id: selectedSubject.id, preferredName: selectedSubject.subjectName.preferred}));
    this.subjectSearchResult = of([]);
  }

  onSubjectChipRemoveClick(subjectId: number): void {
    const relatedSubjects = this.spoilerForm.get('relatedSubjects') as FormArray;
    const index = relatedSubjects.value.findIndex(subject => subjectId === subject.id);

    if (index >= 0) {
      relatedSubjects.removeAt(index);
    }
  }

  onSpoilerFormSubmit() {
  }

  updateSearchButtonText(): string {
    return this.disableSearch ?
      'profile.tabs.timeline.spoilerBox.creation.dialog.option.tagSubject.button.searching' :
      'profile.tabs.timeline.spoilerBox.creation.dialog.option.tagSubject.button.search';
  }

  setSubjectIcon(subjectType: SubjectType): string {
    let subjectMatIcon;
    switch (subjectType) {
      case SubjectType.anime:
        subjectMatIcon = 'live_tv';
        break;
      case SubjectType.book:
        subjectMatIcon = 'book';
        break;
      case SubjectType.music:
        subjectMatIcon = 'music_note';
        break;
      case SubjectType.game:
        subjectMatIcon = 'videogame_asset';
        break;
      case SubjectType.real:
        subjectMatIcon = 'tv';
        break;
      default:
        // use help_outline as a 'question mark' as material icon doesn't have a question mark
        subjectMatIcon = 'help_outline';
        break;
    }

    return subjectMatIcon;
  }


}
