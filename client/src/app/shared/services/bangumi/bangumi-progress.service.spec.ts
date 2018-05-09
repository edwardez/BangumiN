import { TestBed, inject } from '@angular/core/testing';

import { BangumiProgressService } from './bangumi-progress.service';

describe('BangumiProgressService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [BangumiProgressService]
    });
  });

  it('should be created', inject([BangumiProgressService], (service: BangumiProgressService) => {
    expect(service).toBeTruthy();
  }));
});
