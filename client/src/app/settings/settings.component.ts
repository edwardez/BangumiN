import {Component, OnDestroy, OnInit} from '@angular/core';
import {TranslateService} from '@ngx-translate/core';
import {environment} from '../../environments/environment';
import {TitleService} from '../shared/services/page/title.service';
import {take, takeUntil, tap} from 'rxjs/operators';
import {FormBuilder, FormGroup} from '@angular/forms';
import {BanguminUserService} from '../shared/services/bangumin/bangumin-user.service';
import {StorageService} from '../shared/services/storage.service';
import {BanguminUser} from '../shared/models/user/BanguminUser';
import {MatDialog, MatSlideToggleChange} from '@angular/material';
import {RuntimeConstantsService} from '../shared/services/runtime-constants.service';
import {Subject} from 'rxjs';
import {AuthenticationService} from '../shared/services/auth.service';
import {StopCrawlingExplanationDialogComponent} from './stop-crawling-explanation-dialog/stop-crawling-explanation-dialog.component';

@Component({
  selector: 'app-settings',
  templateUrl: './settings.component.html',
  styleUrls: ['./settings.component.scss']
})
export class SettingsComponent implements OnInit, OnDestroy {

  availableLanguage = environment.availableLanguages;
  availableAppThemes = environment.availableAppThemes;
  showA11YViolationTheme = false;
  stopCrawling = false;
  settingsForm: FormGroup;
  userSettings: BanguminUser;

  private ngUnsubscribe: Subject<void> = new Subject<void>();

  constructor(
    private authenticationService: AuthenticationService,
    private banguminUserService: BanguminUserService,
    private dialog: MatDialog,
    private formBuilder: FormBuilder,
    private storageService: StorageService,
    private titleService: TitleService,
    private translateService: TranslateService
  ) {
  }

  ngOnInit() {
    this.translateService.get('settings.name')
      .pipe(
        take(1),
      )
      .subscribe(settingsPageTitle => {
        this.titleService.title = settingsPageTitle;
      });


    this.banguminUserService.getUserSettings()
      .subscribe(userSettings => {
        if (!userSettings) {
          this.authenticationService.logout();
        }

        this.banguminUserService.userSubject.next(userSettings);
        this.userSettings = userSettings;

        let showA11YViolationTheme = false;
        if (this.userSettings.appTheme === 'bangumi-pink-blue' || this.userSettings.showA11YViolationTheme) {
          showA11YViolationTheme = true;
        }

        this.buildSettingsForm(userSettings, showA11YViolationTheme);
      });
  }

  buildSettingsForm(userSettings: BanguminUser, showA11YViolationTheme: boolean) {
    this.settingsForm = this.formBuilder.group({
      appLanguage: [userSettings.appLanguage],
      bangumiLanguage: [userSettings.bangumiLanguage],
      appTheme: [userSettings.appTheme],
      showA11YViolationTheme: showA11YViolationTheme,
      stopCrawling: [userSettings.stopCrawling]
    });


    this.onSettingsFormChange();
  }

  onSettingsFormChange() {
    this.settingsForm.valueChanges
      .pipe(
        tap(formValues => {
          // only set language if it's different from current settings
          if (this.translateService.currentLang !== formValues.appLanguage) {
            this.translateService.use(formValues.appLanguage).subscribe(translatedObjects => {
              // also update the title
              this.titleService.title = translatedObjects.settings.name;
            });

          }
        },
        takeUntil(this.ngUnsubscribe)
      ))
      .subscribe(formValues => {
        const newUserSettings = new BanguminUser().deserialize(formValues);
        newUserSettings.id = this.userSettings.id;
        this.banguminUserService.userSubject.next(newUserSettings);
        this.banguminUserService.postUserSettings(newUserSettings).subscribe();

      });
  }

  /**
   * reset theme to the default one if user has selected a11y violation theme and they want to hide these options
   * @param event
   */
  resetA11YViolationOptionsIfSelected(event: MatSlideToggleChange) {
    if (event.checked === false && this.settingsForm.get('appTheme').value === 'bangumi-pink-blue') {
      this.settingsForm.patchValue(
        {
          'appTheme': RuntimeConstantsService.defaultAppTheme
        }
      );
    }
  }

  showStopCrawlingExplanationDialog() {
    this.dialog.open(StopCrawlingExplanationDialogComponent, {});
  }

  setLanguage(lang: string) {
    this.translateService.use(lang);
  }

  ngOnDestroy(): void {
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

}
