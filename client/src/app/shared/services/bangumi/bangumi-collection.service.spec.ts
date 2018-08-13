import {TestBed, inject} from '@angular/core/testing';

import {BangumiCollectionService} from './bangumi-collection.service';

describe('BangumiCollectionService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [BangumiCollectionService]
    });
  });

  it('should be created', inject([BangumiCollectionService], (service: BangumiCollectionService) => {
    expect(service).toBeTruthy();
  }));
});
