import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { NavComponent } from './nav.component';
import {MaterialFlexModule} from '../../../material-flex.module';
import {SidenavService} from '../../shared/services/sidenav.service';
import {StorageService} from '../../shared/services/storage.service';
import {AuthenticationService} from '../../shared/services/auth.service';
import {HttpClientModule} from '@angular/common/http';
import {environment} from '../../../environments/environment';
import {tokenGetter} from '../../app.module';
import {InterceptorsModule} from '../../shared/interceptors/interceptors.module';
import {JwtModule} from '@auth0/angular-jwt';
import {BangumiUserService} from '../../shared/services/bangumi/bangumi-user.service';

describe('NavComponent', () => {
  let component: NavComponent;
  let fixture: ComponentFixture<NavComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      imports: [
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
      declarations: [ NavComponent ],
      providers: [
        SidenavService,
        StorageService,
        AuthenticationService,
        BangumiUserService
      ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(NavComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
