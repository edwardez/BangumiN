import {TestBed} from '@angular/core/testing';

import {BanguminUserSummaryService} from './bangumin-user-summary.service';

describe('BanguminUserSummaryService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: BanguminUserSummaryService = TestBed.get(BanguminUserSummaryService);
    expect(service).toBeTruthy();
  });
});
