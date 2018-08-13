import {TestBed, inject} from '@angular/core/testing';

import {OauthInterceptor} from './oauth.interceptor';

describe('OauthInterceptor', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [OauthInterceptor]
    });
  });

  it('should be created', inject([OauthInterceptor], (service: OauthInterceptor) => {
    expect(service).toBeTruthy();
  }));
});
