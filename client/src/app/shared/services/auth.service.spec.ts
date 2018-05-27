import {TestBed} from '@angular/core/testing';
import {HttpClientTestingModule, HttpTestingController} from '@angular/common/http/testing';

import {AuthenticationService} from './auth.service';
import {StorageService} from './storage.service';
import {JwtHelperService} from '@auth0/angular-jwt';
import {Observable} from 'rxjs/Observable';
import {HttpClient, HttpHeaders, HttpResponse} from '@angular/common/http';
import {environment} from '../../../environments/environment';
import {BangumiUser} from '../models/BangumiUser';

describe('HeroesService', () => {

    describe('#isAuthenticated', () => {

        let authenticationService: AuthenticationService;
        let httpClientSpy: { get: jasmine.Spy, post: jasmine.Spy };
        let storageServiceSpy: { getJwtToken: jasmine.Spy };
        let jwtHelperSpy: { isTokenExpired: jasmine.Spy };

        beforeEach(() => {
            TestBed.configureTestingModule({});
            jwtHelperSpy = jasmine.createSpyObj('JwtHelperService', ['isTokenExpired']);
            storageServiceSpy = jasmine.createSpyObj('StorageService', ['getJwtToken']);
            httpClientSpy = jasmine.createSpyObj('HttpClient', ['get', 'post']);
            authenticationService = new AuthenticationService(<any> httpClientSpy, <any>storageServiceSpy, <any>jwtHelperSpy);
        });

        it('should return false if token is not presented, and it\'s expired', () => {
            jwtHelperSpy.isTokenExpired.and.returnValue(true);
            storageServiceSpy.getJwtToken.and.returnValue(Observable.of(null));
            authenticationService.isAuthenticated().subscribe(isAuthenticated => {
                expect(isAuthenticated).toBe(false);
            });
        });

        it('should return false if token is not presented, and it\'s not expired', () => {
            jwtHelperSpy.isTokenExpired.and.returnValue(false);
            storageServiceSpy.getJwtToken.and.returnValue(Observable.of(null));
            authenticationService.isAuthenticated().subscribe(isAuthenticated => {
                expect(isAuthenticated).toBe(false);
            });
        });

        it('should return false if token can be found, but it\'s expired', () => {
            jwtHelperSpy.isTokenExpired.and.returnValue(true);
            storageServiceSpy.getJwtToken.and.returnValue(Observable.of('dummy token'));
            authenticationService.isAuthenticated().subscribe(isAuthenticated => {
                expect(isAuthenticated).toBe(false);
            });
        });

        it('should return true if token can be found, and it\'s not expired', () => {
            jwtHelperSpy.isTokenExpired.and.returnValue(false);
            storageServiceSpy.getJwtToken.and.returnValue(Observable.of('dummy token'));
            authenticationService.isAuthenticated().subscribe(isAuthenticated => {
                expect(isAuthenticated).toBe(true);
            });
        });

    });

    describe('#verifyAccessToken', () => {

        let authenticationService: AuthenticationService;
        let httpClientSpy: { get: jasmine.Spy, post: jasmine.Spy };
        let storageServiceSpy: { getJwtToken: jasmine.Spy, setJwtToken: jasmine.Spy, setAccessToken: jasmine.Spy, setBangumiUser: jasmine.Spy };
        let jwtHelperSpy: { isTokenExpired: jasmine.Spy };
        let httpClient: HttpClient;
        let httpTestingController: HttpTestingController;
        const BANGUMI_API_URL = environment.BANGUMI_API_URL;


        beforeEach(() => {
            jwtHelperSpy = jasmine.createSpyObj('JwtHelperService', ['isTokenExpired']);
            storageServiceSpy = jasmine.createSpyObj('StorageService', ['getJwtToken', 'setAccessToken', 'setBangumiUser', 'setJwtToken']);
            httpClientSpy = jasmine.createSpyObj('HttpClient', ['get', 'post']);

            TestBed.configureTestingModule({
                imports: [HttpClientTestingModule],
                providers: [
                    AuthenticationService,
                    {provide: StorageService, useValue: storageServiceSpy},
                    {provide: JwtHelperService, useValue: jwtHelperSpy}
                ]
            });

            httpClient = TestBed.get(HttpClient);
            httpTestingController = TestBed.get(HttpTestingController);
            authenticationService = TestBed.get(AuthenticationService);
        });

        afterEach(() => {
            // After every test, assert that there are no more pending requests.
            httpTestingController.verify();
        });

        it('can set jwtToken, accessToken, user info correctly', () => {
            const dummyToken = 'dummyToken';
            const dummyUserId = 1;
            const dummyUser: BangumiUser = new BangumiUser().deserialize({
                'id': 1,
                'url': 'http://bgm.tv/user/test',
                'username': 'test',
                'nickname': 'test',
                'avatar': {
                    'large': '',
                    'medium': '',
                    'small': ''
                },
                'sign': ''
            });

            authenticationService.verifyAccessToken(dummyToken).subscribe(res => {
                expect(storageServiceSpy.setJwtToken.calls.allArgs()).toEqual([[dummyToken]]);
                expect(storageServiceSpy.setAccessToken.calls.allArgs()).toEqual([[dummyToken]]);
                expect(storageServiceSpy.setBangumiUser.calls.allArgs()).toEqual([[dummyUser]]);
            });

            const reqVerifyJwt = httpTestingController.expectOne(`${environment.BACKEND_AUTH_URL}/jwt/token`);
            expect(reqVerifyJwt.request.method).toEqual('POST');

            const expectedResponse = new HttpResponse(
                {
                    status: 200,
                    statusText: 'OK',
                    body: {'user_id': dummyUserId},
                    headers: new HttpHeaders({'Authorization': `Bearer ${dummyToken}`})
                });

            reqVerifyJwt.event(expectedResponse);

            const reqBangumiUserInfo = httpTestingController.expectOne(`${environment.BANGUMI_API_URL}/user/${dummyUserId}`);
            expect(reqBangumiUserInfo.request.method).toEqual('GET');
            reqBangumiUserInfo.flush(dummyUser);

        });


    });
});


