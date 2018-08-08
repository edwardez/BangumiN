import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {environment} from '../../../../environments/environment';
import {TranslateService} from '@ngx-translate/core';
import {BanguminUser} from '../../models/user/BanguminUser';
import {StorageService} from '../storage.service';
import {catchError, filter, map, switchMap, take, tap} from 'rxjs/operators';
import {BehaviorSubject, concat, Observable, of, Subject, throwError as observableThrowError} from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class BanguminUserService {

  userSubject: Subject<BanguminUser> = new BehaviorSubject<BanguminUser>(null);

  constructor(private http: HttpClient,
              private storageService: StorageService,
              private translateService: TranslateService) {
  }

  /**
   * post user Settings to the server and store the response in local storage
   * @param settings user settings object
   */
  public postUserSettings(settings: any): any {
    const options = {withCredentials: true};
    return this.http.post(`${environment.BACKEND_API_URL}/user/${settings.id}/setting`, settings, options)
      .pipe(tap((updatedUserSettings: BanguminUser) => {
        this.storageService.setBanguminUser(updatedUserSettings);
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
          // if user info is in localStorage and username has at least 1 string
          if (banguminUserFromStorage && banguminUserFromStorage.id.length >= 1) {
            return this.http.get(`${environment.BACKEND_API_URL}/user/${banguminUserFromStorage.id}/setting`, options)
              .pipe(
                map(banguminUserFromHttp => {
                  const banguminUser: BanguminUser = new BanguminUser().deserialize(banguminUserFromHttp);
                  this.storageService.setBanguminUser(banguminUser);
                  return banguminUser;
                })
              );
          }

          // else return an empty Observable
          return of();
        }
      ),
      catchError((err) => {
        return observableThrowError(err);
      })
    );
  }

  /**
   * reliably update user Settings, with both speed and accuracy in mind, first time get it from local storage(ensure the speed)
   * second time get it from server(ensure settings are the latest)
   *
   * @param id user id
   */
  public reliablyUpdateUserSettings(id?: string): void {
    const userSettingsServiceArray = [this.storageService.getBanguminUser(), this.getUserSettings()];

    concat.apply(this, userSettingsServiceArray)
      .pipe(
        take(userSettingsServiceArray.length),
        filter(banguminUser => !!banguminUser),
      )
      .subscribe(banguminUser => {
        this.userSubject.next(banguminUser);
      });


    // subscribe to change in userSubject
    this.userSubject
      .pipe(
        filter(banguminUser => !!banguminUser),
      ).subscribe(banguminUser => {
      this.updateUserSettings(banguminUser);
    });
  }

  /**
   * update user settings immediately
   * currently only app language setting will be updated
   * @param settings
   */
  public updateUserSettings(settings: BanguminUser): void {
    if (this.translateService.currentLang !== settings.appLanguage) {
      this.translateService.use(settings.appLanguage);
    }
  }


  /**
   * set default language by detecting the browser language
   * fallback to en-US if user browser doesn't contain languages that we currently support
   */
  public setDefaultLanguage() {
    this.translateService.addLangs(['en-US', 'zh-Hans']);
    const browserLang = this.translateService.getBrowserLang();
    let defaultLang: string;
    if (browserLang.match(/en/)) {
      defaultLang = 'en-US';
    } else if (browserLang.match(/zh/)) {
      defaultLang = 'zh-Hans';
    } else {
      defaultLang = 'en-US';
    }
    this.translateService.setDefaultLang(defaultLang);
    this.translateService.use(defaultLang);
  }
}
