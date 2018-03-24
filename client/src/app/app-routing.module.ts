import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AppGuard } from './app.guard';
import {LoginBangumiComponent} from './auth/login-bangumi/login-bangumi.component';
import {DashboardComponent} from './home/dashboard/dashboard.component';
import {ActivateBangumiComponent} from './auth/login-bangumi/activate-bangumi/activate-bangumi.component';
import {ProgressComponent} from './home/progress/progress.component';
import {ProfileComponent} from './home/profile/profile.component';
import {SettingsComponent} from './settings/settings.component';

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
        path: 'profile',
        component: ProfileComponent
      },
      {
        path: 'settings',
        component: SettingsComponent
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
export class AppRoutingModule { }
