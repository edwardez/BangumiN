import {Injectable} from '@angular/core';
import {BehaviorSubject} from 'rxjs';
import {take} from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class NavBarService {

  visibleSubject: BehaviorSubject<boolean> = new BehaviorSubject(true);

  constructor() {
  }

  hide() {
    this.visibleSubject.next(false);
  }

  show() {
    this.visibleSubject.next(true);
  }

  toggle() {
    this.visibleSubject
      .pipe(
        take(1)
      )
      .subscribe(visible => this.visibleSubject.next(!visible));
  }
}
