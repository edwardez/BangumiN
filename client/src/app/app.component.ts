import {Component, OnDestroy, OnInit, Output} from '@angular/core';
import {Subject} from 'rxjs';
import {DeviceWidth} from './shared/enums/device-width.enum';
import {takeUntil} from 'rxjs/operators';
import {LayoutService} from './shared/services/layout/layout.service';
import {BanguminUserService} from './shared/services/bangumin/bangumin-user.service';
import {GoogleAnalyticsService} from './shared/services/analytics/google-analytics.service';
import {BanguminCsrfService} from './shared/services/bangumin/bangumin-csrf.service';
import {CookieService} from 'ngx-cookie';
import {environment} from '../environments/environment';
import {TranslateService} from '@ngx-translate/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit, OnDestroy {

  title = 'BangumiN';

  @Output()
  currentDeviceWidth: DeviceWidth;

  private ngUnsubscribe: Subject<void> = new Subject<void>();

  constructor(
    private banguminUserService: BanguminUserService,
    private banguminCsrfService: BanguminCsrfService,
    private cookieService: CookieService,
    private layoutService: LayoutService,
    private googleAnalyticsService: GoogleAnalyticsService,
    private translateService: TranslateService) {
  }

  ngOnInit(): void {
    this.getXsrfToken();
    this.updateDeviceWidth();
    this.setAppInitialSettings();
    this.googleAnalyticsService.subscribe();
  }

  ngOnDestroy(): void {
    this.googleAnalyticsService.unsubscribe();
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

  setAppInitialSettings(): void {
    const availableLanguages = Object.keys(environment.availableLanguages);
    this.translateService.addLangs(availableLanguages);
    this.banguminUserService.updateUserSettingsEfficiently();
  }


  updateDeviceWidth() {
    this.layoutService.deviceWidth
      .pipe(
        takeUntil(this.ngUnsubscribe)
      )
      .subscribe(observedDeviceWidth => {
        this.currentDeviceWidth = observedDeviceWidth;
      });
  }

  getXsrfToken() {
    this.banguminCsrfService.getCsrfToken().subscribe( response => {
      if (response && response.csrfToken) {
        this.cookieService.put('XSRF-TOKEN', response.csrfToken);
      }
    });
  }


}
