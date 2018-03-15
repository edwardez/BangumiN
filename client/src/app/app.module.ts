import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';

import { ServiceWorkerModule } from '@angular/service-worker';
import { AppComponent } from './app.component';

import { environment } from '../environments/environment';
import {HttpClient, HttpClientModule} from '@angular/common/http';
import {TranslateLoader, TranslateModule} from '@ngx-translate/core';
import {TranslateHttpLoader} from '@ngx-translate/http-loader';
import {FlexLayoutModule} from '@angular/flex-layout';
import { LoginBangumiComponent } from './auth/login-bangumi/login-bangumi.component';
import { DashboardComponent } from './home/dashboard/dashboard.component';
import {AppGuard} from './app.guard';

import {MatCardModule} from '@angular/material/card';
import {MatButtonModule, MatSidenavModule, MatToolbarModule} from '@angular/material';
import { NavComponent } from './common/nav/nav.component';
import { ActivateBangumiComponent } from './auth/login-bangumi/activate-bangumi/activate-bangumi.component';
import {AuthenticationService} from './shared/services/auth.service';
import {TokenStorage} from './shared/services/token-storage.service';
import {AUTH_SERVICE, PROTECTED_FALLBACK_PAGE_URI, PUBLIC_FALLBACK_PAGE_URI} from 'ngx-auth';

@NgModule({
  declarations: [
    AppComponent,
    LoginBangumiComponent,
    DashboardComponent,
    NavComponent,
    ActivateBangumiComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    MatCardModule,
    MatButtonModule,
    MatToolbarModule,
    MatSidenavModule,
    FlexLayoutModule,
    TranslateModule.forRoot({
      loader: {
        provide: TranslateLoader,
        useFactory: HttpLoaderFactory,
        deps: [HttpClient]
      }
    }),
    ServiceWorkerModule.register('/ngsw-worker.js', { enabled: environment.production })
  ],
  providers: [AppGuard,
    AuthenticationService,
    TokenStorage,
    { provide: PROTECTED_FALLBACK_PAGE_URI, useValue: '/' },
    { provide: PUBLIC_FALLBACK_PAGE_URI, useValue: '/login' },
    {
      provide: AUTH_SERVICE,
      deps: [ AuthenticationService ],
      useFactory: factory
    }],
  bootstrap: [AppComponent]
})
export class AppModule { }

// required for AOT compilation
export function HttpLoaderFactory(http: HttpClient) {
  return new TranslateHttpLoader(http);
}

export function factory(authenticationService: AuthenticationService) {
  return authenticationService;
}
