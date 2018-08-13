import {inject, TestBed} from '@angular/core/testing';

import {ReviewDialogService} from './review-dialog.service';

describe('ReviewDialogService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [ReviewDialogService]
    });
  });

  it('should be created', inject([ReviewDialogService], (service: ReviewDialogService) => {
    expect(service).toBeTruthy();
  }));
});
