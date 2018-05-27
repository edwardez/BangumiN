import {TestBed, inject} from '@angular/core/testing';

import {BangumiSearchService} from './bangumi-search.service';

describe('BangumiSearchService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [BangumiSearchService]
    });
  });

  it('should be created', inject([BangumiSearchService], (service: BangumiSearchService) => {
    expect(service).toBeTruthy();
  }));
});
