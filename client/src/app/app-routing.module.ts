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
import {SpoilerSingleWrapperComponent} from './user/timeline/spoilers/spoiler-single/spoiler-single-wrapper/spoiler-single-wrapper.component';

const routes: Routes = [
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
    path: 'user/:id/timeline/spoilers/:postId',
    component: SpoilerSingleWrapperComponent,
  },
  {
    path: 'user/:id',
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
    path: '',
    redirectTo: 'login',
    pathMatch: 'full'
  },
  {
    path: '**',
    redirectTo: 'login'
  }
];


@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {
}
