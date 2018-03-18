import { TestBed, inject } from '@angular/core/testing';

import { BangumiUserService } from './bangumi-user.service';

describe('BangumiUserService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [BangumiUserService]
    });
  });

  it('should be created', inject([BangumiUserService], (service: BangumiUserService) => {
    expect(service).toBeTruthy();
  }));
});
