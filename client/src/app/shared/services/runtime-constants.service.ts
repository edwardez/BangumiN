import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class RuntimeConstantsService {

  static defaultUserId = '0';
  static defaultAppLanguage = 'zh-Hans';
  static defaultBangumiLanguage = 'original';
  static defaultAppTheme = 'bangumin-material-blue-teal';
  static defaultShowA11YViolationTheme = false;


  constructor() { }
}