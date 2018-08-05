import {inject, TestBed} from '@angular/core/testing';

import {BanguminUserService} from './bangumin-user.service';

describe('BanguminUserService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [BanguminUserService]
    });
  });

  it('should be created', inject([BanguminUserService], (service: BanguminUserService) => {
    expect(service).toBeTruthy();
  }));
});
