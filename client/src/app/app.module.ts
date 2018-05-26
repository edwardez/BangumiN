import {BrowserModule, Title} from '@angular/platform-browser';
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
import {MaterialLayoutCommonModule} from '../material-layout-common.module';
import {ProgressComponent} from './home/progress/progress.component';
import {ProfileComponent} from './home/profile/profile.component';
import {BangumiUserService} from './shared/services/bangumi/bangumi-user.service';
import {SettingsComponent} from './settings/settings.component';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {BanguminHomeModule} from './home/home.module';
import {KeysPipe} from './shared/pipe/keys.pipe';
import {BanguminCommonComponentModule} from './common/common.module';
import {BangumiSearchService} from './shared/services/bangumi/bangumi-search.service';
import {FullSearchComponent} from './search/full-search/full-search.component';
import {HttpsPipe} from './shared/pipe/https.pipe';
import {SingleSubjectComponent} from './subject/single-subject/single-subject.component';
import {BangumiSubjectService} from './shared/services/bangumi/bangumi-subject.service';
import {ReviewDialogComponent} from './subject/review-dialog/review-dialog.component';
import {BangumiCollectionService} from './shared/services/bangumi/bangumi-collection.service';
import {SideNavContentComponent} from './common/side-nav-content/side-nav-content.component';
import {EpisodeDialogComponent} from './home/progress/episode-dialog/episode-dialog.component';

@NgModule({
    declarations: [
        AppComponent,
        SideNavContentComponent,
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
        SingleSubjectComponent,
        ReviewDialogComponent,
        EpisodeDialogComponent

    ],
    imports: [
        BrowserModule,
        AppRoutingModule,
        HttpClientModule,
        MaterialLayoutCommonModule,
        BanguminHomeModule,
        BanguminCommonComponentModule,
        FormsModule,
        ReactiveFormsModule,
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
    entryComponents: [
        ReviewDialogComponent,
        EpisodeDialogComponent
    ],
    providers: [AppGuard,
        Title,
        AuthenticationService,
        BangumiUserService,
        BangumiSearchService,
        BangumiSubjectService,
        BangumiCollectionService,
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
