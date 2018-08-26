import {inject, TestBed} from '@angular/core/testing';

import {RuntimeConstantsService} from './runtime-constants.service';

describe('RuntimeConstantsService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [RuntimeConstantsService]
    });
  });

  it('should be created', inject([RuntimeConstantsService], (service: RuntimeConstantsService) => {
    expect(service).toBeTruthy();
  }));
});
