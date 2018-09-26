import {inject, TestBed} from '@angular/core/testing';

import {CacheInterceptor} from './cache.interceptor';

describe('CacheInterceptor', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [CacheInterceptor]
    });
  });

  it('should be created', inject([CacheInterceptor], (service: CacheInterceptor) => {
    expect(service).toBeTruthy();
  }));
});
