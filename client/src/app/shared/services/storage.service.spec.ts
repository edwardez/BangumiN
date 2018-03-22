import { TestBed, inject } from '@angular/core/testing';

import { StorageService } from './storage.service';
import {BangumiUser} from '../models/BangumiUser';
import {Observable} from 'rxjs/Observable';

describe('TokenStorageService', () => {
  let storageService: StorageService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [StorageService]
    });
    storageService = TestBed.get(StorageService);
    storageService.clear();
  });

  afterEach(() => {
    storageService.clear();
  });

  it('should be created', inject([StorageService], (service: StorageService) => {
    expect(service).toBeTruthy();
  }));

  it('should empty localStorage at first', () => {
    storageService.getAccessToken().subscribe( res => {
      expect(res).toBe(null);
    });

    storageService.getRefreshToken().subscribe( res => {
      expect(res).toBe(null);
    });

    storageService.getJwtToken().subscribe( res => {
      expect(res).toBe(null);
    });

    storageService.getBangumiUser().subscribe( res => {
      expect(res).toBe(null);
    });
  });


  it('should be able to get accessToken, JwtToken, refreshToken after calling set method', () => {
    storageService.setAccessToken('accessToken');
    storageService.getAccessToken().subscribe( res => {
      expect(res).toBe('accessToken');
    });

    storageService.setRefreshToken('refreshToken');
    storageService.getRefreshToken().subscribe( res => {
      expect(res).toBe('refreshToken');
    });

    storageService.setJwtToken('jwtToken');
    storageService.getJwtToken().subscribe( res => {
      expect(res).toBe('jwtToken');
    });
  });


  it('should be able to get bangumiUser info after calling set method', () => {

    const bangumiUser: BangumiUser = new BangumiUser().deserialize({
      id: '',
      avatar: {'large': 'https://lain.bgm.tv/pic/user/l/icon.jpg',
        'medium': 'https://lain.bgm.tv/pic/user/m/icon.jpg',
        'small': 'https://lain.bgm.tv/pic/user/s/icon.jpg'},
      nickname: '',
      username: ''
    });

    storageService.setBangumiUser(bangumiUser);
    storageService.getBangumiUser().subscribe( res => {
      expect(new BangumiUser().deserialize(res)).toEqual(bangumiUser);
    });
  });


});
