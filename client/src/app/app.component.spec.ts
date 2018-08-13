import {TestBed, async} from '@angular/core/testing';
import {RouterTestingModule} from '@angular/router/testing';
import {AppComponent} from './app.component';
import {NavComponent} from './common/nav/nav.component';
import {BanguminSharedModule} from '../bangumin-shared.module';
import {SidenavService} from './shared/services/sidenav.service';
import {StorageService} from './shared/services/storage.service';
import {AuthenticationService} from './shared/services/auth.service';
import {HttpClientModule} from '@angular/common/http';
import {JwtHelperService, JwtModule} from '@auth0/angular-jwt';
import {tokenGetter} from './app.module';
import {environment} from '../environments/environment';
import {InterceptorsModule} from './shared/interceptors/interceptors.module';
import {BangumiUserService} from './shared/services/bangumi/bangumi-user.service';

describe('AppComponent', () => {
  beforeEach(async(() => {
    TestBed.configureTestingModule({
      imports: [
        RouterTestingModule,
        BanguminSharedModule,
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
        AppComponent,
        NavComponent
      ],
      providers: [
        SidenavService,
        StorageService,
        AuthenticationService,
        JwtHelperService,
        BangumiUserService
      ]
      ,
    }).compileComponents();
  }));
  it('should create the app', async(() => {
    const fixture = TestBed.createComponent(AppComponent);
    const app = fixture.debugElement.componentInstance;
    expect(app).toBeTruthy();
  }));
  it(`should have as title 'BangumiN'`, async(() => {
    const fixture = TestBed.createComponent(AppComponent);
    const app = fixture.debugElement.componentInstance;
    expect(app.title).toEqual('BangumiN');
  }));
});
