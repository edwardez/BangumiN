import {TestBed} from '@angular/core/testing';

import {BangumiStatsService} from './bangumi-stats.service';

describe('BangumiStatsService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: BangumiStatsService = TestBed.get(BangumiStatsService);
    expect(service).toBeTruthy();
  });
});
