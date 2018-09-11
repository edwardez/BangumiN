import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {AppGuard} from './app.guard';
import {LoginBangumiComponent} from './auth/login-bangumi/login-bangumi.component';
import {ActivateBangumiComponent} from './auth/login-bangumi/activate-bangumi/activate-bangumi.component';
import {ProgressComponent} from './home/progress/progress.component';
import {ProfileComponent} from './user/profile.component';
import {SettingsComponent} from './settings/settings.component';
import {FullSearchComponent} from './search/full-search/full-search.component';
import {CollectionHomeComponent} from './user/collection/collection-home/collection-home.component';
import {SubjectComponent} from './subject/subject.component';
// noinspection TsLint
import {SpoilerSingleWrapperComponent} from './user/timeline/spoilers/spoiler-single/spoiler-single-wrapper/spoiler-single-wrapper.component';
import {PageNotFoundComponent} from './common/page-not-found/page-not-found.component';
import {TosComponent} from './documents/tos/tos.component';
import {PrivacyComponent} from './documents/privacy/privacy.component';
import {AboutHomeComponent} from './documents/about/about-home/about-home.component';
import {HelpHomeComponent} from './documents/help/help-home/help-home.component';

const routes: Routes = [
  {
    path: '',
    redirectTo: 'progress',
    pathMatch: 'full'
  },
  {
    path: '',
    canActivate: [AppGuard],
    children: [
      {
        path: 'progress',
        component: ProgressComponent
      },
      {
        path: 'settings',
        component: SettingsComponent
      },
    ]
  },
  {
    path: 'user/:userId/timeline/spoilers/:spoilerId',
    component: SpoilerSingleWrapperComponent,
  },
  {
    path: 'user/:userId',
    component: ProfileComponent,
    children: [
      {
        path: '',
        component: CollectionHomeComponent,
      },
      {
        path: 'statistics',
        loadChildren: 'app/user/profile-stats/profile-stats.module#ProfileStatsModule'
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
    path: 'search',
    component: FullSearchComponent
  },
  {
    path: 'subject/:id',
    component: SubjectComponent
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
