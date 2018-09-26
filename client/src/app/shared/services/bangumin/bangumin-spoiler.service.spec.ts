import {inject, TestBed} from '@angular/core/testing';

import {BanguminSpoilerService} from './bangumin-spoiler.service';

describe('BanguminSpoilerService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [BanguminSpoilerService]
    });
  });

  it('should be created', inject([BanguminSpoilerService], (service: BanguminSpoilerService) => {
    expect(service).toBeTruthy();
  }));
});
