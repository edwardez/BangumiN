import {Component, OnInit} from '@angular/core';
import {TranslateService} from '@ngx-translate/core';
import {environment} from '../../environments/environment';
import {TitleService} from '../shared/services/page/title.service';
import {tap} from 'rxjs/operators';
import {FormBuilder, FormGroup} from '@angular/forms';
import {BanguminUserService} from '../shared/services/bangumin/bangumin-user.service';
import {StorageService} from '../shared/services/storage.service';
import {BanguminUser} from '../shared/models/user/BanguminUser';

@Component({
  selector: 'app-settings',
  templateUrl: './settings.component.html',
  styleUrls: ['./settings.component.scss']
})
export class SettingsComponent implements OnInit {

  availableLanguage = environment.availableLanguage;
  settingsForm: FormGroup;
  userSettings: BanguminUser;

  constructor(
    private banguminUserService: BanguminUserService,
    private formBuilder: FormBuilder,
    private storageService: StorageService,
    private titleService: TitleService,
    private translateService: TranslateService
  ) {
  }

  ngOnInit() {
    this.translateService.get('settings.name')
      .subscribe(settingsPageTitle => {
        this.titleService.title = settingsPageTitle;
      });


    this.banguminUserService.getUserSettings().subscribe(userSettings => {
      console.log(userSettings);
      this.userSettings = userSettings;
      this.buildSettingsForm(userSettings);
    });
  }

  buildSettingsForm(userSettings: BanguminUser) {
    this.settingsForm = this.formBuilder.group({
      appLanguage: [userSettings.appLanguage],
      bangumiLanguage: [userSettings.bangumiLanguage],
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
        const newUserSettings = Object.assign(formValues);
        newUserSettings.id = this.userSettings.id;
        this.banguminUserService.postUserSettings(newUserSettings).subscribe(response => {
        });

      });
  }

  setLanguage(lang: string) {
    this.translateService.use(lang);
  }

}
