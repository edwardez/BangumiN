import { TestBed, inject } from '@angular/core/testing';

import { StorageService } from './storage.service';

describe('TokenStorageService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [StorageService]
    });
  });

  it('should be created', inject([StorageService], (service: StorageService) => {
    expect(service).toBeTruthy();
  }));
});
