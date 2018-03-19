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
import {MatButtonModule, MatIconModule, MatListModule, MatSidenavModule, MatToolbarModule} from '@angular/material';
import {MatMenuModule} from '@angular/material/menu';
import { NavComponent } from './common/nav/nav.component';
import { ActivateBangumiComponent } from './auth/login-bangumi/activate-bangumi/activate-bangumi.component';
import {AuthenticationService} from './shared/services/auth.service';
import {TokenStorage} from './shared/services/token-storage.service';
import {JwtModule} from '@auth0/angular-jwt';
import {InterceptorsModule} from './shared/interceptors/interceptors.module';
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';
import {SidenavService} from './shared/services/sidenav.service';
import {MaterialFlexModule} from '../material-flex.module';

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
    ServiceWorkerModule.register('/ngsw-worker.js', { enabled: environment.production })
  ],
  providers: [AppGuard,
    AuthenticationService,
    TokenStorage,
    SidenavService
    ],
  bootstrap: [AppComponent]
})
export class AppModule { }

// required for AOT compilation
export function HttpLoaderFactory(http: HttpClient) {
  return new TranslateHttpLoader(http);
}

export function tokenGetter() {
  return localStorage.getItem('jwtToken');
}
