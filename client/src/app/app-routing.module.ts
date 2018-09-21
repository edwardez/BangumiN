import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {AppGuard} from './app.guard';
import {LoginBangumiComponent} from './auth/login-bangumi/login-bangumi.component';
import {ActivateBangumiComponent} from './auth/login-bangumi/activate-bangumi/activate-bangumi.component';
import {SettingsComponent} from './settings/settings.component';
import {SubjectComponent} from './subject/subject.component';
// tslint:disable-next-line:max-line-length
import {SpoilerSingleWrapperComponent} from './user/timeline/spoilers/spoiler-single/spoiler-single-wrapper/spoiler-single-wrapper.component';
import {PageNotFoundComponent} from './common/page-not-found/page-not-found.component';
import {TosComponent} from './documents/tos/tos.component';
import {PrivacyComponent} from './documents/privacy/privacy.component';
import {AboutHomeComponent} from './documents/about/about-home/about-home.component';
import {HelpHomeComponent} from './documents/help/help-home/help-home.component';
import {WelcomeComponent} from './home/welcome/welcome.component';
import {SearchResultComponent} from './search/search-result/search-result.component';
import {SingleSubjectComponent} from './subject/single-subject/single-subject.component';

const routes: Routes = [
  {
    path: '',
    redirectTo: 'welcome',
    pathMatch: 'full'
  },
  {
    path: '',
    canActivate: [AppGuard],
    children: [
      {
        path: 'settings',
        component: SettingsComponent
      },
    ]
  },
  {
    path: 'search',
    canActivate: [AppGuard],
    component: SearchResultComponent
  },
  {
    path: 'user/:userId/timeline/spoilers/:spoilerId',
    component: SpoilerSingleWrapperComponent,
  },
  {
    path: 'user/:userId',
    children: [
      {
        path: '',
        redirectTo: 'statistics',
        pathMatch: 'full'
      },
      {
        path: 'statistics',
        loadChildren: 'app/user/profile-statistics/profile-statistics.module#ProfileStatisticsModule'
      },

      {
        path: 'timeline/spoilers',
        loadChildren: 'app/user/timeline/spoilers/spoilers.module#SpoilersModule'
      },
      {
        path: '**',
        redirectTo: '',
        pathMatch: 'full'
      },
    ]
  },
  {
    path: 'welcome',
    canActivate: [AppGuard],
    component: WelcomeComponent
  },
  {
    path: 'subject/:subjectId',
    component: SubjectComponent,
    children: [
      {
        path: '',
        component: SingleSubjectComponent
      },
      {
        path: 'statistics',
        loadChildren: 'app/subject/subject-statistics/subject-statistics.module#SubjectStatisticsModule'
      },
      {
        path: '**',
        redirectTo: '',
        pathMatch: 'full'
      },
    ]
  },
  {
    path: 'login',
    component: LoginBangumiComponent
  },
  {
    path: 'activate',
    component: ActivateBangumiComponent
  },
  {
    path: 'help',
    component: HelpHomeComponent
  },
  {
    path: 'about',
    component: AboutHomeComponent
  },
  {
    path: 'privacy',
    component: PrivacyComponent
  },
  {
    path: 'tos',
    component: TosComponent
  },
  {
    path: '**',
    component: PageNotFoundComponent
  }
];


@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {
}
