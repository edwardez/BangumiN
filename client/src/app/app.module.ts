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
import {AppGuard} from './app.guard';

import {NavComponent} from './common/nav/nav.component';
import {ActivateBangumiComponent} from './auth/login-bangumi/activate-bangumi/activate-bangumi.component';
import {AuthenticationService} from './shared/services/auth.service';
import {StorageService} from './shared/services/storage.service';
import {JwtModule} from '@auth0/angular-jwt';
import {InterceptorsModule} from './shared/interceptors/interceptors.module';
import {SidenavService} from './shared/services/sidenav.service';
import {MaterialFlexModule} from '../material-flex.module';
import {ProgressComponent} from './home/progress/progress.component';
import {ProfileComponent} from './home/profile/profile.component';
import {BangumiUserService} from './shared/services/bangumi/bangumi-user.service';
import {SettingsComponent} from './settings/settings.component';
import {FormsModule} from '@angular/forms';
import {BanguminHomeModule} from './home/home.module';
import {KeysPipe} from './shared/pipe/keys.pipe';
import {BanguminCommonComponentModule} from './common/common.module';
import {BangumiSearchService} from './shared/services/bangumi/bangumi-search.service';
import { FullSearchComponent } from './search/full-search/full-search.component';
import { HttpsPipe } from './shared/pipe/https.pipe';

@NgModule({
  declarations: [
    AppComponent,
    LoginBangumiComponent,
    DashboardComponent,
    NavComponent,
    ActivateBangumiComponent,
    ProgressComponent,
    ProfileComponent,
    SettingsComponent,
    KeysPipe,
    FullSearchComponent,
    HttpsPipe,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    BanguminHomeModule,
    BanguminCommonComponentModule,
    FormsModule,
    MaterialFlexModule,
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
    ServiceWorkerModule.register('/ngsw-worker.js', {enabled: environment.production})
  ],
  providers: [AppGuard,
    AuthenticationService,
    BangumiUserService,
    BangumiSearchService,
    StorageService,
    SidenavService,
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
