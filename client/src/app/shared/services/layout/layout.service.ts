import { Injectable } from '@angular/core';
import {BreakpointObserver, Breakpoints} from '@angular/cdk/layout';
import {DeviceWidth} from '../../enums/device-width.enum';
import {BehaviorSubject, Subject} from 'rxjs/index';
import {BangumiUser} from '../../models/BangumiUser';

@Injectable({
  providedIn: 'root'
})
export class LayoutService {

  deviceWidth: Subject<DeviceWidth> = new BehaviorSubject<DeviceWidth>(null);

  /**
   * static method that will decide whether device width is xsmall
   * method name is hard to in recognize but it's intended since we need to be in consistent with responsive API of flex-layout
   * @param {DeviceWidth} deviceWidth device width
   * @returns {boolean} whether device width is xsmall
   */
  static xs(deviceWidth: DeviceWidth): boolean {
    return deviceWidth === DeviceWidth.xs;
  }

  /**
   * static method that will decide whether device width is small
   * method name is hard to in recognize but it's intended since we need to be in consistent with responsive API of flex-layout
   * @param {DeviceWidth} deviceWidth device width
   * @returns {boolean} whether device width is small
   */
  static sm(deviceWidth: DeviceWidth): boolean {
    return deviceWidth === DeviceWidth.sm;
  }

  /**
   * static method that will decide whether device width is medium
   * method name is hard to in recognize but it's intended since we need to be in consistent with responsive API of flex-layout
   * @param {DeviceWidth} deviceWidth device width
   * @returns {boolean} whether device width is medium
   */
  static md(deviceWidth: DeviceWidth): boolean {
    return deviceWidth === DeviceWidth.md;
  }

  /**
   * static method that will decide whether device width is large
   * method name is hard to in recognize but it's intended since we need to be in consistent with responsive API of flex-layout
   * @param {DeviceWidth} deviceWidth device width
   * @returns {boolean} whether device width is large
   */
  static lg(deviceWidth: DeviceWidth): boolean {
    return deviceWidth === DeviceWidth.lg;
  }

  /**
   * static method that will decide whether device width is xlarge
   * method name is hard to in recognize but it's intended since we need to be in consistent with responsive API of flex-layout
   * @param {DeviceWidth} deviceWidth device width
   * @returns {boolean} whether device width is xlarge
   */
  static xl(deviceWidth: DeviceWidth): boolean {
    return deviceWidth === DeviceWidth.xl;
  }

  /**
   * static method that will decide whether device width equals to or is smaller of than small
   * method name is hard to in recognize but it's intended since we need to be in consistent with responsive API of flex-layout
   * @param {DeviceWidth} deviceWidth device width
   * @returns {boolean} whether device width equals to or is smaller of than small
   */
  static ltSm(deviceWidth: DeviceWidth): boolean {
    return deviceWidth <= DeviceWidth.sm;
  }

  /**
   * static method that will decide whether device width equals to or is smaller of than medium
   * method name is hard to in recognize but it's intended since we need to be in consistent with responsive API of flex-layout
   * @param {DeviceWidth} deviceWidth device width
   * @returns {boolean} whether device width equals to or is smaller of than medium
   */
  static ltMd(deviceWidth: DeviceWidth): boolean {
    return deviceWidth <= DeviceWidth.md;
  }

  /**
   * static method that will decide whether device width equals to or is smaller of than large
   * method name is hard to in recognize but it's intended since we need to be in consistent with responsive API of flex-layout
   * @param {DeviceWidth} deviceWidth device width
   * @returns {boolean} whether device width equals to or is smaller of than large
   */
  static ltLg(deviceWidth: DeviceWidth): boolean {
    return deviceWidth <= DeviceWidth.lg;
  }

  /**
   * static method that will decide whether device width equals to or is smaller of than xlarge
   * method name is hard to in recognize but it's intended since we need to be in consistent with responsive API of flex-layout
   * @param {DeviceWidth} deviceWidth device width
   * @returns {boolean} whether device width equals to or is smaller of than xlarge
   */
  static ltXl(deviceWidth: DeviceWidth): boolean {
    return deviceWidth <= DeviceWidth.xl;
  }

  /**
   * static method that will decide whether device width is bigger than xsmall
   * method name is hard to in recognize but it's intended since we need to be in consistent with responsive API of flex-layout
   * @param {DeviceWidth} deviceWidth device width
   * @returns {boolean} whether device width is bigger than xsmall
   */
  static gtXs(deviceWidth: DeviceWidth): boolean {
    return deviceWidth > DeviceWidth.xs;
  }

  /**
   * static method that will decide whether device width is bigger than small
   * method name is hard to in recognize but it's intended since we need to be in consistent with responsive API of flex-layout
   * @param {DeviceWidth} deviceWidth device width
   * @returns {boolean} whether device width is bigger than small
   */
  static gtSm(deviceWidth: DeviceWidth): boolean {
    return deviceWidth > DeviceWidth.sm;
  }

  /**
   * static method that will decide whether device width is bigger than medium
   * method name is hard to in recognize but it's intended since we need to be in consistent with responsive API of flex-layout
   * @param {DeviceWidth} deviceWidth device width
   * @returns {boolean} whether device width is bigger than medium
   */
  static gtMd(deviceWidth: DeviceWidth): boolean {
    return deviceWidth > DeviceWidth.md;
  }

  /**
   * static method that will decide whether device width is bigger than large
   * method name is hard to in recognize but it's intended since we need to be in consistent with responsive API of flex-layout
   * @param {DeviceWidth} deviceWidth device width
   * @returns {boolean} whether device width is bigger than large
   */
  static gtLg(deviceWidth: DeviceWidth): boolean {
    return deviceWidth > DeviceWidth.lg;
  }

  constructor(private breakpointObserver: BreakpointObserver) {
    this.updateDeviceWidth();
  }


  private updateDeviceWidth() {
    this.breakpointObserver.observe([
      Breakpoints.XSmall,
    ]).subscribe(result => {
      if (result.matches) {
        this.deviceWidth.next(DeviceWidth.xs);
      }
    });

    this.breakpointObserver.observe([
      Breakpoints.Small,
    ]).subscribe(result => {
      if (result.matches) {
        this.deviceWidth.next(DeviceWidth.sm);
      }
    });

    this.breakpointObserver.observe([
      Breakpoints.Medium,
    ]).subscribe(result => {
      if (result.matches) {
        this.deviceWidth.next(DeviceWidth.md);
      }
    });

    // treate large or higher as large
    this.breakpointObserver.observe([
      Breakpoints.Large,
      Breakpoints.XLarge,
    ]).subscribe(result => {
      if (result.matches) {
        this.deviceWidth.next(DeviceWidth.lg);
      }
    });


  }
}
