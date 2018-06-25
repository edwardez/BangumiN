import {Injectable} from '@angular/core';
import {MatSnackBar} from '@angular/material';
import {TranslateService} from '@ngx-translate/core';
import {switchMap, take} from 'rxjs/operators';
import {Observable} from 'rxjs/internal/Observable';
import {of} from 'rxjs/internal/observable/of';

@Injectable({
  providedIn: 'root'
})
export class SnackBarService {

  constructor(private snackBar: MatSnackBar,
              private translateService: TranslateService) {
  }

  /**
   * open a snackBar
   */
  public openSimpleSnackBar(translationLabel: string, config = {duration: 4000}, action?: ''): Observable<any> {
    return this.translateService.get(translationLabel)
      .pipe(
        take(1),
        switchMap(translatedString => {
          return of(this.snackBar.open(translatedString, action, config));
        })
      );

  }


}
