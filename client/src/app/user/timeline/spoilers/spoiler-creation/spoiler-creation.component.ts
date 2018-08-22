import {Component, ElementRef, OnInit, ViewChild} from '@angular/core';
import {AuthenticationService} from '../../../../shared/services/auth.service';
import {catchError, finalize, map} from 'rxjs/operators';
import {BangumiUser} from '../../../../shared/models/BangumiUser';

import Quill from 'quill';
import {MatAutocompleteSelectedEvent, MatAutocompleteTrigger, MatChipInputEvent} from '@angular/material';
import {FormControl} from '@angular/forms';
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

Quill.register(new SpoilerClass(), true);

const icons = Quill.import('ui/icons');
icons['clean'] = '<mat-icon class="mat-icon material-icons">visibility</mat-icon>';


export class SearchConfig {
  // expect user to tolerate a shorter timeout period here
  static readonly SEARCH_TIME_OUT = 3000;
  static readonly MAX_RESULT = 10;
}
@Component({
  selector: 'app-spoiler-creation',
  templateUrl: './spoiler-creation.component.html',
  styleUrls: ['./spoiler-creation.component.scss']
})
export class SpoilerCreationComponent implements OnInit {

  bangumiUser: BangumiUser;
  quill: Quill;

  disableSearch = false;
  selectable = true;
  removable = true;
  addOnBlur = false;
  separatorKeysCodes: number[] = [];
  subjectCtrl = new FormControl();
  filteredSubjects: Observable<SubjectBase[]>;
  subjects: string[] = [];


  @ViewChild('subjectInput')
  subjectInput: ElementRef;

  @ViewChild('matAutocompleteTrigger')
  matAutocompleteTrigger: MatAutocompleteTrigger;

  constructor(private authenticationService: AuthenticationService,
              private bangumiSearchService: BangumiSearchService,
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
    return new SubjectBase(
      undefined, undefined, undefined, searchKeyWord,
      'No result', undefined, undefined, undefined, undefined);
  }

  ngOnInit() {

    this.filteredSubjects = of([]);
  }

  addBold(event) {
    this.quill.format('spoiler', true);
  }

  setEditor(quill: Quill) {
    this.quill = quill;
  }

  add(event: MatChipInputEvent): void {
    const input = event.input;
    const value = event.value;

    // Add our subject
    if ((value || '').trim()) {
      this.subjects.push(value.trim());
    }

    // Reset the input value
    if (input) {
      input.value = '';
    }

    this.subjectCtrl.setValue(null);
  }

  remove(subject: string): void {
    const index = this.subjects.indexOf(subject);

    if (index >= 0) {
      this.subjects.splice(index, 1);
    }
  }

  selected(event: MatAutocompleteSelectedEvent): void {
    this.subjects.push(event.option.viewValue);
    this.subjectInput.nativeElement.value = '';
    this.subjectCtrl.setValue(null);
  }

  submitSearch(event) {
    event.stopPropagation();
    this.disableSearch = true;
    this.updateSearchButtonText();
    const searchKeyWord = this.subjectInput.nativeElement.value;
    this.filteredSubjects = this.bangumiSearchService.searchSubject(this.subjectInput.nativeElement.value,
      undefined, 'small', undefined, SearchConfig.MAX_RESULT, SearchConfig.SEARCH_TIME_OUT).pipe(
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
        subjectMatIcon = 'live_tv';
        break;
    }

    return subjectMatIcon;
  }


}
