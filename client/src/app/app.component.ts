import {Component, HostBinding, OnDestroy, OnInit, Output} from '@angular/core';
import {Subject} from 'rxjs/index';
import {DeviceWidth} from './shared/enums/device-width.enum';
import {takeUntil} from 'rxjs/operators';
import {LayoutService} from './shared/services/layout/layout.service';
import {StorageService} from './shared/services/storage.service';
import {BanguminUserService} from './shared/services/bangumin/bangumin-user.service';
import {OverlayContainer} from '@angular/cdk/overlay';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit, OnDestroy {

  // @HostBinding('class.') lightTheme = true;

  title = 'BangumiN';

  @Output()
  currentDeviceWidth: DeviceWidth;

  private ngUnsubscribe: Subject<void> = new Subject<void>();

  constructor(
    private banguminUserService: BanguminUserService,
    private layoutService: LayoutService,
    private storageService: StorageService) {
  }

  ngOnInit(): void {
    this.updateDeviceWidth();
    this.setAppInitialSettings();
  }

  ngOnDestroy(): void {
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

  setAppInitialSettings(): void {
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


}
