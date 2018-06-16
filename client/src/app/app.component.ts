import {Component, OnDestroy, OnInit, Output} from '@angular/core';
import {TranslateService} from '@ngx-translate/core';
import {Subject} from 'rxjs/index';
import {DeviceWidth} from './shared/enums/device-width.enum';
import {takeUntil} from 'rxjs/operators';
import {LayoutService} from './shared/services/layout/layout.service';

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
    private translate: TranslateService,
    private layoutService: LayoutService) {

    this.setDefaultLanguage(translate);
  }

  ngOnInit(): void {
    this.updateDeviceWidth();
  }

  ngOnDestroy(): void {
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

  setDefaultLanguage(translate) {
    translate.addLangs(['en-US', 'zh-Hans']);
    const browserLang = this.translate.getBrowserLang();
    let defaultLang: string;
    if (browserLang.match(/en/)) {
      defaultLang = 'en-US';
    } else if (browserLang.match(/zh/)) {
      defaultLang = 'zh-Hans';
    }
    translate.setDefaultLang(defaultLang);
    this.translate.use(defaultLang);
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


}
