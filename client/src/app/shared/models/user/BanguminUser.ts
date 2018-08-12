import {Serializable} from '../Serializable';
import {RuntimeConstantsService} from '../../services/runtime-constants.service';


export interface BanguminUserSchema {
  id: string;
  appLanguage?: string;
  bangumiLanguage?: string;
  appTheme: string;
  showA11YViolationTheme: boolean;
}

export class BanguminUser implements Serializable<BanguminUser>, BanguminUserSchema {
  id: string;
  appLanguage?: string;
  bangumiLanguage?: string;
  appTheme: string;
  showA11YViolationTheme: boolean;

  constructor() {
    this.id = RuntimeConstantsService.defaultUserId;
    this.appLanguage = RuntimeConstantsService.defaultAppLanguage;
    this.bangumiLanguage = RuntimeConstantsService.defaultBangumiLanguage;
    this.appTheme = RuntimeConstantsService.defaultAppTheme;
    this.showA11YViolationTheme = RuntimeConstantsService.defaultShowA11YViolationTheme;
  }

  deserialize(input) {
    this.id = input.id || RuntimeConstantsService.defaultUserId;
    this.appLanguage = input.appLanguage || RuntimeConstantsService.defaultAppLanguage;
    this.bangumiLanguage = input.bangumiLanguage || RuntimeConstantsService.defaultBangumiLanguage;
    this.appTheme = input.appTheme || RuntimeConstantsService.defaultAppTheme;
    this.showA11YViolationTheme = input.showA11YViolationTheme || RuntimeConstantsService.defaultShowA11YViolationTheme;
    return this;
  }


}


