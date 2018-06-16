import {BrowserModule} from '@angular/platform-browser';
import {NgModule} from '@angular/core';

import {AppRoutingModule} from './app-routing.module';

import {ServiceWorkerModule} from '@angular/service-worker';
import {AppComponent} from './app.component';

import {environment} from '../environments/environment';
import {HttpClient, HttpClientModule} from '@angular/common/http';
import {TranslateLoader, TranslateModule} from '@ngx-translate/core';
import {TranslateHttpLoader} from '@ngx-translate/http-loader';
import {LoginBangumiComponent} from './auth/login-bangumi/login-bangumi.component';
import {DashboardComponent} from './home/dashboard/dashboard.component';

import {ActivateBangumiComponent} from './auth/login-bangumi/activate-bangumi/activate-bangumi.component';
import {JwtModule} from '@auth0/angular-jwt';
import {InterceptorsModule} from './shared/interceptors/interceptors.module';
import {BanguminSharedModule} from '../bangumin-shared.module';
import {ProfileComponent} from './home/profile/profile.component';
import {SettingsComponent} from './settings/settings.component';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {BanguminHomeModule} from './home/home.module';
import {KeysPipe} from './shared/pipe/keys.pipe';
import {BanguminCommonComponentModule} from './common/common.module';
import {FullSearchComponent} from './search/full-search/full-search.component';
import {HttpsPipe} from './shared/pipe/https.pipe';
import {SingleSubjectComponent} from './subject/single-subject/single-subject.component';
import {ReviewDialogComponent} from './subject/review-dialog/review-dialog.component';
import {EpisodeDialogComponent} from './home/progress/episode-dialog/episode-dialog.component';
import {CollectionByTypeComponent} from './home/profile/collection/collection-by-type/collection-by-type.component';
import {CookieModule} from 'ngx-cookie';
import {BangumiAuthWaitDialogComponent} from './auth/login-bangumi/bangumi-auth-wait-dialog/bangumi-auth-wait-dialog.component';
import {ProfileModule} from './home/profile/profile.module';

@NgModule({
  declarations: [
    AppComponent,
    LoginBangumiComponent,
    DashboardComponent,
    ActivateBangumiComponent,
    ProfileComponent,
    SettingsComponent,
    KeysPipe,
    FullSearchComponent,
    HttpsPipe,
    SingleSubjectComponent,
    ReviewDialogComponent,
    CollectionByTypeComponent,
    BangumiAuthWaitDialogComponent,

  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    BanguminSharedModule,
    BanguminHomeModule,
    BanguminCommonComponentModule,
    FormsModule,
    ReactiveFormsModule,
    CookieModule.forRoot(),
    JwtModule.forRoot({
      config: {
        tokenGetter: tokenGetter,
        whitelistedDomains: environment.whitelistedDomains,
        blacklistedRoutes: environment.blacklistedRoutes,
      }
    }),
    InterceptorsModule.forRoot(),
    TranslateModule.forRoot({
        loader: {
          provide: TranslateLoader,
          useFactory: HttpLoaderFactory,
          deps: [HttpClient]
        }
      }
    ),
    ServiceWorkerModule.register('/ngsw-worker.js', {enabled: environment.production}),
    ProfileModule
  ],
  entryComponents: [
    ReviewDialogComponent,
    EpisodeDialogComponent,
    BangumiAuthWaitDialogComponent
  ],
  providers: [
  ],
  bootstrap: [AppComponent]
})
export class AppModule {
}

// required for AOT compilation
export function HttpLoaderFactory(http: HttpClient) {
  return new TranslateHttpLoader(http);
}

export function tokenGetter() {
  return localStorage.getItem('jwtToken');
}
