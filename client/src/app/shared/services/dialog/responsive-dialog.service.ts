import {Injectable, TemplateRef} from '@angular/core';
import {MatDialog, MatDialogConfig, MatDialogRef} from '@angular/material';
import {map, take} from 'rxjs/operators';
import {LayoutService} from '../layout/layout.service';
import {DeviceWidth} from '../../enums/device-width.enum';
import {Observable} from 'rxjs/internal/Observable';
import {ComponentType} from '@angular/cdk/portal';

interface DialogSizeConfig {
  width?: string;
  height?: string;
  maxWidth?: string;
  maxHeight?: string;
}

interface ResponsiveDialogSizeConfig {
  onSmScreen?: DialogSizeConfig | null;
  onLtSmScreen?: DialogSizeConfig | null;
}

export interface DialogConfig<D> {
  matDialogConfig?: MatDialogConfig<D>;
  sizeConfig?: ResponsiveDialogSizeConfig;
}

/**
 * A general dialog service which will open dialog responsively according to the config
 * for screen size, if you want to use Angular's default dialog size, set the size to null, if you want to use the predefined
 * size in this service, leave it blank, otherwise the specifies size will be used
 */
@Injectable({
  providedIn: 'root'
})
export class ResponsiveDialogService {

  static readonly defaultDialogSizeOnSmScreen: DialogSizeConfig = {
    width: '100%',
    height: '100%',
    maxWidth: '100vw',
    maxHeight: '100vh',
  };

  static readonly defaultDialogSizeOnLtSmScreen: DialogSizeConfig = {
    width: '50%',
    height: '50%',
    maxWidth: '50vw',
    maxHeight: '50vh',
  };


  constructor(private matDialog: MatDialog,
              private layoutService: LayoutService
  ) {
  }

  /**
   * Set dialog configs
   * @param deviceWidth device width
   * @param receivedDialogConfig dialog config that's passed in
   */
  static createDialogConfig<D>(deviceWidth: DeviceWidth, receivedDialogConfig?: DialogConfig<D>): any {

    const dialogConfig: DialogConfig<D> = receivedDialogConfig || {};
    const matDialogConfig: MatDialogConfig<D> = dialogConfig.matDialogConfig || {};
    matDialogConfig.autoFocus = matDialogConfig.autoFocus || false;

    let dialogSize = null;
    if (LayoutService.ltSm(deviceWidth)) {
      const sizeOnSmScreen = (dialogConfig.sizeConfig || {}).onSmScreen;
      dialogSize = ResponsiveDialogService.setDialogSize(sizeOnSmScreen, ResponsiveDialogService.defaultDialogSizeOnSmScreen);
    } else {
      const sizeOnLtSmScreen = (dialogConfig.sizeConfig || {}).onLtSmScreen;
      dialogSize = ResponsiveDialogService.setDialogSize(sizeOnLtSmScreen, ResponsiveDialogService.defaultDialogSizeOnLtSmScreen);
    }

    if (dialogSize !== null) {
      Object.assign(matDialogConfig, dialogSize);
    }

    return matDialogConfig;
  }

  /**
   * For screen size, if you want to use Angular's default dialog size, set the size to null, if you want to use the predefined
   * size in this service, leave it blank, otherwise the specifies size will be used
   * @param dialogSizeConfig size config object
   * @param defaultSize specified default size
   */
  static setDialogSize(dialogSizeConfig: DialogSizeConfig, defaultSize?: DialogSizeConfig): DialogSizeConfig | null {
    let dialogSize = null;
    if (dialogSizeConfig === undefined) {
      dialogSize = defaultSize || ResponsiveDialogService.defaultDialogSizeOnLtSmScreen;
    } else if (dialogSizeConfig === null) {
      dialogSize = null;
    } else {
      dialogSize = dialogSizeConfig;
    }
    return dialogSize;
  }


  public openDialog<T = any, D = any, R = any>(componentOrTemplateRef: ComponentType<T> | TemplateRef<T>,
                                               dialogConfig?: DialogConfig<D>): Observable<MatDialogRef<T, R>> {

    return this.layoutService.deviceWidth
      .pipe(
        take(1),
        map(deviceWidth => {
          const updatedDialogData = ResponsiveDialogService.createDialogConfig(deviceWidth, dialogConfig);
          return this.matDialog.open(componentOrTemplateRef, updatedDialogData);
        }))
      ;


  }


}
