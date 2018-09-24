import {Injectable} from '@angular/core';
import {BangumiUserRole} from '../enums/bangumi-user-role.enum';

@Injectable({
  providedIn: 'root'
})
export class RuntimeConstantsService {

  static readonly appTitleSuffix = ' | BangumiN';
  // define theme-color meta attr
  static readonly appThemeColor = {
    'bangumin-material-blue-teal': '#2196f3',
    'bangumin-material-dark-pink-blue-grey': '#e91e63',
    'bangumi-pink-blue': '#f09199',
  };
  static readonly maxCacheAge = 200000;  // in milliseconds
  static readonly nonCacheableUrls: Array<string | RegExp> = [/http.*api\/user\/\d+\/setting/, /oauth/, /auth/, /assets/];
  static readonly validUserGroupValues: number[] = Object.keys(BangumiUserRole).map(k => BangumiUserRole[k])
    .filter(v => typeof v === 'number');

  static defaultUserId = null;
  static defaultSubjectId = 0;
  static defaultSpoilerId = '0';
  static defaultAppLanguage = 'zh-Hans';
  static defaultBangumiLanguage = 'original';
  static defaultAppTheme = 'bangumin-material-blue-teal';
  static defaultShowA11YViolationTheme = false;


  constructor() {
    console.log(RuntimeConstantsService.validUserGroupValues);
  }
}
