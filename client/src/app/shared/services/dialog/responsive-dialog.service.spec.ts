import {inject, TestBed} from '@angular/core/testing';

import {ResponsiveDialogService} from './responsive-dialog.service';

describe('ResponsiveDialogService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [ResponsiveDialogService]
    });
  });

  it('should be created', inject([ResponsiveDialogService], (service: ResponsiveDialogService) => {
    expect(service).toBeTruthy();
  }));
});
