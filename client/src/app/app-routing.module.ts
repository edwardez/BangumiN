import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AppGuard } from './app.guard';
import {LoginBangumiComponent} from './auth/login-bangumi/login-bangumi.component';
import {DashboardComponent} from './home/dashboard/dashboard.component';

const routes: Routes = [
  {
    path: '',
    canActivate: [AppGuard],
    children: [
      {
        path: 'dashboard',
        component: DashboardComponent
      },

    ]
  },
  {
    path: 'login',
    component: LoginBangumiComponent
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
