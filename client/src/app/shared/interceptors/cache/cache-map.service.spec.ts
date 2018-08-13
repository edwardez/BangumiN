import {inject, TestBed} from '@angular/core/testing';

import {CacheMapService} from './cache-map.service';

describe('CacheMapService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [CacheMapService]
    });
  });

  it('should be created', inject([CacheMapService], (service: CacheMapService) => {
    expect(service).toBeTruthy();
  }));
});
