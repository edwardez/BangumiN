import {Injectable} from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class RuntimeConstantsService {

  static readonly appTitleSuffix = ' | BangumiN';
  static readonly maxCacheAge = 200000;  // in milliseconds

  static defaultUserId = null;
  static defaultAppLanguage = 'zh-Hans';
  static defaultBangumiLanguage = 'original';
  static defaultAppTheme = 'bangumin-material-blue-teal';
  static defaultShowA11YViolationTheme = false;


  constructor() { }
}
