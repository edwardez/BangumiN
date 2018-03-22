import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ActivateBangumiComponent } from './activate-bangumi.component';
import {ActivatedRoute, Router} from '@angular/router';
import {AuthenticationService} from '../../../shared/services/auth.service';
import {AppRoutingModule} from '../../../app-routing.module';
import {ProgressComponent} from '../../../home/progress/progress.component';
import {ProfileComponent} from '../../../home/profile/profile.component';
import {LoginBangumiComponent} from '../login-bangumi.component';
import {MaterialFlexModule} from '../../../../material-flex.module';
import {APP_BASE_HREF} from '@angular/common';
import {HttpClientModule} from '@angular/common/http';
import {StorageService} from '../../../shared/services/storage.service';
import {tokenGetter} from '../../../app.module';
import {environment} from '../../../../environments/environment';
import {InterceptorsModule} from '../../../shared/interceptors/interceptors.module';
import {JwtModule} from '@auth0/angular-jwt';

describe('ActivateBangumiComponent', () => {
  let component: ActivateBangumiComponent;
  let fixture: ComponentFixture<ActivateBangumiComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      imports: [
        AppRoutingModule,
        MaterialFlexModule,
        HttpClientModule,
        JwtModule.forRoot({
          config: {
            tokenGetter: tokenGetter,
            whitelistedDomains: environment.whitelistedDomains,
            blacklistedRoutes: environment.blacklistedRoutes,
          }
        }),
        InterceptorsModule.forRoot(),
      ],
      declarations: [
        ActivateBangumiComponent,
        ProgressComponent,
        ProfileComponent,
        LoginBangumiComponent],
      providers: [
        AuthenticationService,
        StorageService,
        {provide: APP_BASE_HREF, useValue: '/'}
      ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ActivateBangumiComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
