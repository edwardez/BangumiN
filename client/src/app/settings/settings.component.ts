import {Component, OnInit} from '@angular/core';
import {TranslateService} from '@ngx-translate/core';
import {environment} from '../../environments/environment';

@Component({
  selector: 'app-settings',
  templateUrl: './settings.component.html',
  styleUrls: ['./settings.component.scss']
})
export class SettingsComponent implements OnInit {

  availableLanguage = environment.availableLanguage;
  currentLanguage: string;
  preferredBangumiLanguage: string;

  constructor(
    private translate: TranslateService
  ) {
  }

  ngOnInit() {
    this.currentLanguage = this.translate.currentLang;
    this.preferredBangumiLanguage = 'original';
  }

  setLanguage(lang: string) {
    this.translate.use(lang);
  }

}
