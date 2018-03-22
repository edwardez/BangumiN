import { TestBed, inject } from '@angular/core/testing';

import { AuthenticationService } from './auth.service';
import {HttpClientModule} from '@angular/common/http';
import {environment} from '../../../environments/environment';
import {tokenGetter} from '../../app.module';
import {InterceptorsModule} from '../interceptors/interceptors.module';
import {JwtModule} from '@auth0/angular-jwt';
import {StorageService} from './storage.service';

describe('AuthService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [
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
      providers: [AuthenticationService,
        StorageService]
    });
  });

  it('should be created', inject([AuthenticationService], (service: AuthenticationService) => {
    expect(service).toBeTruthy();
  }));
});
