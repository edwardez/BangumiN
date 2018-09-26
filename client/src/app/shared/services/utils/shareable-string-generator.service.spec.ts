import {TestBed} from '@angular/core/testing';

import {ShareableStringGeneratorService} from './shareable-string-generator.service';

describe('ShareableStringGeneratorService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: ShareableStringGeneratorService = TestBed.get(ShareableStringGeneratorService);
    expect(service).toBeTruthy();
  });
});
