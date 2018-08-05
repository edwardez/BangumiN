import {Component, OnInit} from '@angular/core';
import {TranslateService} from '@ngx-translate/core';
import {environment} from '../../environments/environment';
import {TitleService} from '../shared/services/page/title.service';
import {tap} from 'rxjs/operators';
import {FormBuilder, FormGroup} from '@angular/forms';
import {BanguminUserService} from '../shared/services/bangumin/bangumin-user.service';

@Component({
  selector: 'app-settings',
  templateUrl: './settings.component.html',
  styleUrls: ['./settings.component.scss']
})
export class SettingsComponent implements OnInit {

  availableLanguage = environment.availableLanguage;
  settingsForm: FormGroup;

  constructor(
    private banguminUserService: BanguminUserService,
    private formBuilder: FormBuilder,
    private titleService: TitleService,
    private translateService: TranslateService
  ) {
  }

  ngOnInit() {
    this.translateService.get('settings.name')
      .pipe(tap(settingsPageTitle => {
        this.titleService.title = settingsPageTitle;
      }))
      .subscribe(settingsPageTitle => {
      });

    this.buildSettingsForm();
  }

  buildSettingsForm() {
    this.settingsForm = this.formBuilder.group({
      appLanguage: ['zh-Hans'],
      bangumiLanguage: ['original'],
    });

    this.onSettingsFormChange();
  }

  onSettingsFormChange() {
    this.settingsForm.valueChanges
      .pipe(tap(formValues => {
        // only set language if it's different from current settings
        if (this.translateService.currentLang !== formValues.appLanguage) {
          this.translateService.use(formValues.appLanguage).subscribe(translatedObjects => {
            // also update the title
            this.titleService.title = translatedObjects.settings.name;
          });

        }
      }))
      .subscribe(formValues => {
        this.banguminUserService.updateUserSettings(formValues).subscribe(r => {
        });

      });
  }

  setLanguage(lang: string) {
    this.translateService.use(lang);
  }

}
