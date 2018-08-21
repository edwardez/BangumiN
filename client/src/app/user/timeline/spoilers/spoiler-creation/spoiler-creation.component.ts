import {Component, ElementRef, OnInit, ViewChild} from '@angular/core';
import {AuthenticationService} from '../../../../shared/services/auth.service';
import {map, take} from 'rxjs/operators';
import {BangumiUser} from '../../../../shared/models/BangumiUser';

import Quill from 'quill';
import {MatAutocompleteSelectedEvent, MatAutocompleteTrigger, MatChipInputEvent} from '@angular/material';
import {FormControl} from '@angular/forms';
import {Observable, of} from 'rxjs';
import {BangumiSearchService} from '../../../../shared/services/bangumi/bangumi-search.service';
import {SubjectBase} from '../../../../shared/models/subject/subject-base';

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


@Component({
  selector: 'app-spoiler-creation',
  templateUrl: './spoiler-creation.component.html',
  styleUrls: ['./spoiler-creation.component.scss']
})
export class SpoilerCreationComponent implements OnInit {
  bangumiUser: BangumiUser;
  quill: Quill;

  duringSearch = false;
  selectable = true;
  removable = true;
  addOnBlur = false;
  separatorKeysCodes: number[] = [];
  subjectCtrl = new FormControl();
  filteredSubjects: Observable<SubjectBase[]>;
  subjects: string[] = ['Subject1'];
  allSubjects: string[] = ['Subject1', 'Subject2'];

  @ViewChild('subjectInput')
  subjectInput: ElementRef;

  @ViewChild('matAutocompleteTrigger')
  matAutocompleteTrigger: MatAutocompleteTrigger;

  constructor(private authenticationService: AuthenticationService,
              private bangumiSearchService: BangumiSearchService) {
  }

  ngOnInit() {

    this.authenticationService.userSubject.pipe(
      take(1)
    ).subscribe((bangumiUser: BangumiUser) => {
        this.bangumiUser = bangumiUser;
      }
    );

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
    this.duringSearch = true;
    this.setSearchButtonText();
    this.filteredSubjects = this.bangumiSearchService.searchSubject(this.subjectInput.nativeElement.value, undefined, 'small').pipe(
      take(1),
      map(searchResult => {
        searchResult.subjects.push(new SubjectBase(
          undefined, undefined, undefined, this.subjectInput.nativeElement.value,
          'No result', undefined, undefined, undefined, undefined));
        console.log(searchResult);
        this.duringSearch = false;
        this.setSearchButtonText();
        return searchResult.subjects;
      })
    );
  }

  setSearchButtonText() {
    if (this.duringSearch) {
      return 'cancel search';
    } else {
      return 'search';
    }
  }





}
