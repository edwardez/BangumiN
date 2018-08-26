import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {environment} from '../../../../environments/environment';
import {TranslateService} from '@ngx-translate/core';
import {BanguminUser, BanguminUserSchema} from '../../models/user/BanguminUser';
import {StorageService} from '../storage.service';
import {catchError, filter, map, pairwise, switchMap, take, tap} from 'rxjs/operators';
import {BehaviorSubject, concat, Observable, of, Subject, throwError as observableThrowError} from 'rxjs';
import {OverlayContainer} from '@angular/cdk/overlay';
import {RuntimeConstantsService} from '../runtime-constants.service';

@Injectable({
  providedIn: 'root'
})
export class BanguminUserService {
  // a static copy of userSubject result, the subject version should be used if possible
  static currentBanguminUserSettings: BanguminUserSchema = new BanguminUser();

  userSubject: Subject<BanguminUser> = new BehaviorSubject<BanguminUser>(null);

  constructor(private http: HttpClient,
              private storageService: StorageService,
              private translateService: TranslateService,
              private overlayContainer: OverlayContainer) {
  }


  /**
   * post user Settings to the server and store the response in local storage
   * @param settings user settings object
   */
  public postUserSettings(settings: any): any {
    const options = {withCredentials: true};
    return this.http.post(`${environment.BACKEND_API_URL}/user/${settings.id}/setting`, settings, options)
      .pipe(tap((updatedBanguminUser: BanguminUserSchema) => {
        this.storageService.setBanguminUser(new BanguminUser().deserialize(updatedBanguminUser));
      }));
  }

  /**
   * get current user Settings from the server and put it in local storage
   * if id is not provided, get id from local storage
   * if id is not in local storage, a null will be returned
   */
  public getUserSettings(): Observable<any> {
    const options = {withCredentials: true};

    return this.storageService.getBanguminUser().pipe(
      take(1),
      switchMap(
        banguminUserFromStorage => {
          // if user info is in localStorage and username has at least 1 string and it cannot be 0
          if (banguminUserFromStorage && banguminUserFromStorage.id
            && banguminUserFromStorage.id !== RuntimeConstantsService.defaultUserId) {
            return this.http.get(`${environment.BACKEND_API_URL}/user/${banguminUserFromStorage.id}/setting`, options)
              .pipe(
                map(banguminUserFromHttp => {
                  const banguminUser: BanguminUserSchema = new BanguminUser().deserialize(banguminUserFromHttp);
                  this.storageService.setBanguminUser(banguminUser);
                  return banguminUser;
                })
              );
          }

          // else user hasn't logged in, update default settings then return an empty Observable
          return of(null);
        }
      ),
      catchError((err) => {
        return observableThrowError(err);
      })
    );
  }

  /**
   * efficiently update user Settings, with both speed and accuracy in mind, first time get it from local storage(ensure the speed)
   * second time get it from server(ensure settings are the latest)
   *
   * @param id user id
   */
  public updateUserSettingsEfficiently(id?: string): void {


    const userSettingsServiceArray = [this.storageService.getBanguminUser(), this.getUserSettings()];

    concat.apply(this, userSettingsServiceArray)
      .pipe(
        take(userSettingsServiceArray.length),
        map(banguminUser => {
          if (!banguminUser) {
            this.setDefaultLanguage();
            return new BanguminUser();
          }

          return banguminUser;
        })
      )
      .subscribe(banguminUser => {
        this.userSubject.next(banguminUser);
      });

    // get and set the initial user settings
    this.userSubject.pipe(
      take(1),
    ).subscribe(
      banguminUser => {
        this.setInitialUserSettings(banguminUser);
      }
    );

    // subscribe to userSubject, only update settings if there are any differences
    this.userSubject.pipe(
      filter(banguminUser => !!banguminUser),
      tap(banguminUser => BanguminUserService.currentBanguminUserSettings = banguminUser),
      pairwise()
    ).subscribe(banguminUser => {
      this.updateUserSettings(banguminUser[0], banguminUser[1]);
    });
  }

  /**
   * set default language by detecting the browser language
   * fallback to en-US if user browser doesn't contain languages that we currently support
   */
  public getDefaultLanguage() {
    this.translateService.addLangs(Object.keys(environment.availableLanguages));
    const browserLang = this.translateService.getBrowserLang();
    let defaultLang: string;
    if (browserLang.match(/en/)) {
      defaultLang = 'en-US';
    } else if (browserLang.match(/zh/)) {
      defaultLang = 'zh-Hans';
    } else {
      defaultLang = 'en-US';
    }
    RuntimeConstantsService.defaultAppLanguage = defaultLang;
    return defaultLang;
  }

  // todo: switch case for different filter type(e.g. byYear, byType, byState, etc)
  public getUserProfileStats(username: string): any {
    // todo: cache with subject in the future
    return of([{typ: 'real', rate: 8, adddate: '2016-09-24'},
      {typ: 'anime', rate: 7, adddate: '2017-09-24'},
      {typ: 'real', rate: 4, adddate: '2018-09-24'},
      {typ: 'real', rate: 7, adddate: '2016-09-24'},
      {typ: 'real', rate: 6, adddate: '2017-09-24'},
      {typ: 'anime', rate: 10, adddate: '2018-09-24'},
      {typ: 'anime', rate: 2, adddate: '2018-09-24'},
      {typ: 'anime', rate: 5, adddate: '2016-09-24'},
      {typ: 'anime', rate: 1, adddate: '2017-09-24'},
      {typ: 'real', rate: 2, adddate: '2016-09-24'},
      {typ: 'anime', rate: 3, adddate: '2017-09-24'},
      {typ: 'anime', rate: 4, adddate: '2017-09-24'},
      {typ: 'anime', rate: 4, adddate: '2018-09-24'},
      {typ: 'real', rate: 6, adddate: '2016-09-24'},
      {typ: 'anime', rate: 7, adddate: '2017-09-24'},
      {typ: 'real', rate: 8, adddate: '2018-09-24'},
      {typ: 'anime', rate: 9, adddate: '2017-09-24'}
    ]);
  }


  /**
   * initially set user settings immediately
   * @param settings
   */
  private setInitialUserSettings(settings: BanguminUserSchema): void {
    this.translateService.use(settings.appLanguage);
    this.overlayContainer.getContainerElement()
      .classList.add(settings.appTheme);
    document.body.classList.add(settings.appTheme);
  }

  /**
   * update user settings immediately, use {@link this.areObjectsSame()}
   * to check differences and do nothing if old and new settings are the same
   * @param oldSettings old user settings
   * @param newSettings new user settings
   */
  private updateUserSettings(oldSettings: BanguminUserSchema, newSettings: BanguminUserSchema): void {
    if (this.areObjectsSame(oldSettings, newSettings)) {
      return;
    }

    // old settings values might be unreliable, check through the translate service to get current language
    if (this.translateService.currentLang !== newSettings.appLanguage) {
      this.translateService.use(newSettings.appLanguage);
    }

    this.updateAppTheme(oldSettings.appTheme, newSettings.appTheme);

  }

  /**
   * update app theme, do nothing if old theme and new theme are the same string
   * @param oldTheme
   * @param newTheme
   */
  private updateAppTheme(oldTheme: string, newTheme: string): void {
    if (oldTheme === newTheme) {
      return;
    }

    this.overlayContainer.getContainerElement().classList.remove(oldTheme);
    this.overlayContainer.getContainerElement().classList.add(newTheme);
    document.body.classList.remove(oldTheme);
    document.body.classList.add(newTheme);

  }

  /**
   * set default language by detecting the browser language
   * fallback to en-US if user browser doesn't contain languages that we currently support
   */
  private setDefaultLanguage() {
    const defaultLanguage = this.getDefaultLanguage();
    this.translateService.setDefaultLang(defaultLanguage);
    this.translateService.use(defaultLanguage);
  }

  /**
   * check whether values in two objects are the same, only the first level is checked
   */
  private areObjectsSame(firstObject: object, secondObject: object) {
    return Object.keys(firstObject).every(key => firstObject[key] === secondObject[key]);
  }
}
