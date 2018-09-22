import {Injectable} from '@angular/core';
import {Title} from '@angular/platform-browser';
import {RuntimeConstantsService} from '../runtime-constants.service';
import {TranslateService} from '@ngx-translate/core';

@Injectable({
  providedIn: 'root'
})
export class TitleService {
  _title = '';

  get title(): string {
    return this._title;
  }

  set title(title: string) {
    this._title = title;
    if (title !== '') {
      title = `${title}`;
    }
    this.bodyTitle.setTitle(`${title}`);
  }

  constructor(private bodyTitle: Title, private translateService: TranslateService) {
  }

  setTitle(title: string, suffix = RuntimeConstantsService.appTitleSuffix): string {
    this.title = title + suffix;
    return this.title;
  }

  setTitleByTranslationLabel(titleTranslationLabel: string, translationVariables = {},
                             suffix = RuntimeConstantsService.appTitleSuffix): void {
    this.translateService.get(titleTranslationLabel, translationVariables).subscribe(
      translatedString => {
        this.setTitle(translatedString, suffix);
      }
    );
  }
}
