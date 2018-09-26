import { TestBed } from '@angular/core/testing';

import { BanguminCsrfService } from './bangumin-csrf.service';

describe('BanguminCsrfService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: BanguminCsrfService = TestBed.get(BanguminCsrfService);
    expect(service).toBeTruthy();
  });
});
