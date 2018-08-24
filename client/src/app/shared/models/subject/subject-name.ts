import {BanguminUserService} from '../../services/bangumin/bangumin-user.service';
import {RuntimeConstantsService} from '../../services/runtime-constants.service';

export class SubjectName {

  // original name, == name field in bangumi API
  original: string;

  // chinese name, == nameCN field in bangumi API
  zhHans: string;

  // user preferred name, set dynamically according to settngs
  preferred: string;

  // secondary preferred name
  secondary: string;

  constructor(original = '', zhHans = '', preferred = '', secondary = '') {
    // original always exists while zhHans might be empty, use original name as a fallback if zh-Hans name doesn't exist
    this.original = original || '';
    this.zhHans = zhHans || this.original;

    const bangumiLanguage: string = BanguminUserService.currentBanguminUserSettings.bangumiLanguage
      || RuntimeConstantsService.defaultBangumiLanguage;

    // set preferred and secondary language
    switch (bangumiLanguage) {
      case 'original':
        this.preferred = this.original || '';
        // if zh-Hans is the same as preferred name, there's no need to display
        this.secondary = this.zhHans !== this.original ? this.zhHans : '';
        break;
      case 'zh-Hans':
        this.preferred = this.zhHans || '';
        this.secondary = this.original !== this.zhHans ? this.original : '';
        break;
      default:
        this.preferred = this.original || '';
        // if zh-Hans is the same as preferred name, there's no need to display
        this.secondary = this.zhHans !== this.original ? this.zhHans : '';
    }
  }
}
