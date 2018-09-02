import {Component, ElementRef, OnInit, ViewChild} from '@angular/core';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import {MatAutocompleteSelectedEvent, MatAutocompleteTrigger, MatDialogRef} from '@angular/material';
import {Observable, of, throwError} from 'rxjs';
import {catchError, finalize, map} from 'rxjs/operators';
import Quill from 'quill';
import {BangumiUser} from '../../../../shared/models/BangumiUser';
import {AuthenticationService} from '../../../../shared/services/auth.service';
import {BangumiSearchService} from '../../../../shared/services/bangumi/bangumi-search.service';
import {SubjectBase} from '../../../../shared/models/subject/subject-base';
import {SearchSubjectsResponseSmall} from '../../../../shared/models/search/search-subjects-response-small';
import {SubjectType} from '../../../../shared/enums/subject-type.enum';
import {RuntimeConstantsService} from '../../../../shared/services/runtime-constants.service';
import {BanguminSpoilerService} from '../../../../shared/services/bangumin/bangumin-spoiler.service';

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

export class SpoilerCreationConfig {
  // maximum spoiler text length
  static readonly MAX_SPOILER_TEXT_LENGTH = 500;
  // expect user to tolerate a shorter timeout period here
  static readonly SEARCH_TIME_OUT = 3000;
  static readonly MAX_SEARCH_RESULT = 10;
  // user can only add up to this number of related subjects
  static readonly MAX_RELATED_SUBJECT_NUMBER = 2;
}

// a single mat-chip chip value, record the subject that user
export class SelectedRelatedSubject {
  id: number;

  name: {
    preferred: string;
  };

  constructor(id = RuntimeConstantsService.defaultSubjectId, preferredName = '') {
    this.id = id;
    this.name = {preferred: preferredName};
  }

}

@Component({
  selector: 'app-spoiler-creation',
  templateUrl: './spoiler-creation.component.html',
  styleUrls: ['./spoiler-creation.component.scss']
})
export class SpoilerCreationComponent implements OnInit {

  disableSearch = false;

  bangumiUser: BangumiUser;
  spoilerEditor: Quill;
  spoilerForm: FormGroup;
  subjectSearchResult: Observable<SubjectBase[]>;

  @ViewChild('subjectInput')
  subjectInput: ElementRef;

  @ViewChild(MatAutocompleteTrigger)
  matAutocompleteTrigger: MatAutocompleteTrigger;

  constructor(private authenticationService: AuthenticationService,
              private bangumiSearchService: BangumiSearchService,
              private banguminSpoilerService: BanguminSpoilerService,
              private formBuilder: FormBuilder,
              private spoilerDialog: MatDialogRef<SpoilerCreationComponent>
  ) {
  }

  get SpoilerCreationConfig() {
    return SpoilerCreationConfig;
  }

  get spoilerTextEditorControl() {
    return this.spoilerForm.get('spoilerText');
  }

  get relatedSubjectsControl() {
    return this.spoilerForm.get('relatedSubjects');
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
    icons['clean'] = '<mat-icon class="mat-icon material-icons mat-icon-color-foreground">visibility</mat-icon>';

    this.initializeSpoilerForm();
  }

  initializeEditor(quill: Quill) {
    this.spoilerEditor = quill;
  }

  initializeSpoilerForm() {
    this.spoilerForm = this.formBuilder.group(
      {
        spoilerText: [''],
        relatedSubjects: [[], Validators.maxLength(SpoilerCreationConfig.MAX_RELATED_SUBJECT_NUMBER)]
      }
    );
  }

  markSpoilerText(event) {
    this.spoilerEditor.format('spoiler', true);
  }

  // perform a new subject search and attach a user-defined subject, currently this will be called if user clicks search or presses enter
  onTriggerSubjectSearch(event) {
    event.stopPropagation();
    const searchKeyWord = this.subjectInput.nativeElement.value;
    // if search is currently disabled or search keyword is empty, do nothing and return
    if (this.disableSearch || !searchKeyWord) {
      return;
    }

    this.disableSearch = true;
    this.updateSearchButtonText();
    this.subjectSearchResult = this.bangumiSearchService.searchSubject(searchKeyWord,
      undefined, 'small', undefined, SpoilerCreationConfig.MAX_SEARCH_RESULT, SpoilerCreationConfig.SEARCH_TIME_OUT).pipe(
      map(searchResult => {
        const selectedSubjects = this.spoilerForm.get('relatedSubjects').value || [];
        const selectedSubjectsSet = new Set(selectedSubjects.map(subject => subject.id));
        searchResult.subjects = searchResult.subjects.filter(subject =>
          subject.id === RuntimeConstantsService.defaultSubjectId || !selectedSubjectsSet.has(subject.id));
        return SpoilerCreationComponent.generateSubjectSearchResult(searchKeyWord, searchResult).subjects;
      }),
      catchError((error) => {
        return throwError(error);
      }),
      finalize(() => {
          this.updateSearchButtonText();
          // anyhow, reset the search button so user can perform next search
          this.disableSearch = false;
        this.matAutocompleteTrigger.openPanel();
        }
      )
    );

  }

  onAddChipAutoCompletionClick(event: MatAutocompleteSelectedEvent): void {
    this.subjectInput.nativeElement.value = '';
    const subjectToAdd = <SubjectBase>event.option.value;
    const selectedSubjectsControl = this.spoilerForm.get('relatedSubjects');
    const selectedSubjects = selectedSubjectsControl.value || [];
    // if user has specified multiple self-defined subject, then these subject id will all be default value, use && subject.id to skip them
    if (subjectToAdd.id === RuntimeConstantsService.defaultSubjectId) {
      // if it is an user self defined subject, name shouldn't be same
      if (!selectedSubjects.find(subject => subject.subjectName.preferred === subjectToAdd.subjectName.preferred)) {
        selectedSubjectsControl.setValue([...selectedSubjects, subjectToAdd]);
      }
    } else {
      // else, id shouldn't be the same
      if (!selectedSubjects.find(subject => subject.id === subjectToAdd.id)) {
        selectedSubjectsControl.setValue([...selectedSubjects, subjectToAdd]);
      }
    }

    this.subjectSearchResult = of([]);
  }

  onSubjectChipRemoveClick(subjectToRemove: SubjectBase): void {
    const relatedSubjectsControl = this.spoilerForm.get('relatedSubjects');
    relatedSubjectsControl.setValue((relatedSubjectsControl.value || []).filter(subject => subject.id !== subjectToRemove.id));
  }

  onSpoilerFormSubmit() {
    //
    // console.log(this.spoilerForm.value);
    this.banguminSpoilerService.postNewSpoiler(this.spoilerForm.value).subscribe(console.log);
  }

  onSpoilerDialogClose() {
    this.spoilerDialog.close();
  }

  updateSearchButtonText(): string {
    return this.disableSearch ?
      'profile.tabs.timeline.spoilerBox.creation.dialog.option.tagSubject.button.searching' :
      'profile.tabs.timeline.spoilerBox.creation.dialog.option.tagSubject.button.search';
  }

  getSubjectIcon(subjectType: SubjectType): string {
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
