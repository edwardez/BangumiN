import {Injectable} from '@angular/core';
import { MatSnackBar, MatSnackBarConfig, MatSnackBarRef, SimpleSnackBar } from '@angular/material/snack-bar';
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
  public openSimpleSnackBar(messageTranslationLabel = '', actionTranslationLabel = '',
                            config: MatSnackBarConfig = {duration: 4000},): Observable<MatSnackBarRef<SimpleSnackBar>> {
    return this.translateService.get([messageTranslationLabel, actionTranslationLabel])
      .pipe(
        switchMap(translatedString => {
            const message = translatedString[messageTranslationLabel];
            const action = translatedString[actionTranslationLabel];
            return of(this.snackBar.open(message, action, config));
          },
        ),
        take(1),
      );

  }


}
