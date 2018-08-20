import {Component, ElementRef, OnInit, ViewChild} from '@angular/core';
import {AuthenticationService} from '../../../../shared/services/auth.service';
import {map, startWith, take} from 'rxjs/operators';
import {BangumiUser} from '../../../../shared/models/BangumiUser';

import Quill from 'quill';
import {MatAutocompleteSelectedEvent, MatChipInputEvent} from '@angular/material';
import {COMMA, ENTER} from '@angular/cdk/keycodes';
import {FormControl} from '@angular/forms';
import {Observable} from 'rxjs';

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

  visible = true;
  selectable = true;
  removable = true;
  addOnBlur = false;
  separatorKeysCodes: number[] = [ENTER, COMMA];
  subjectCtrl = new FormControl();
  filteredSubjects: Observable<string[]>;
  subjects: string[] = ['Subject1'];
  allSubjects: string[] = ['Subject1', 'Subject2'];

  @ViewChild('subjectInput') subjectInput: ElementRef;

  constructor(private authenticationService: AuthenticationService) {
    this.filteredSubjects = this.subjectCtrl.valueChanges.pipe(
      startWith(null),
      map((subject: string | null) => subject ? this._filter(subject) : this.allSubjects.slice()));
  }

  ngOnInit() {

    this.authenticationService.userSubject.pipe(
      take(1)
    ).subscribe((bangumiUser: BangumiUser) => {
        this.bangumiUser = bangumiUser;
      }
    );
  }

  addBold(event) {
    this.quill.format('spoiler', true);
    console.log(this.quill.getContents());
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

  private _filter(value: string): string[] {
    const filterValue = value.toLowerCase();

    return this.allSubjects.filter(subject => subject.toLowerCase().indexOf(filterValue) === 0);
  }



}
