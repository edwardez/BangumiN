import authenticationMiddleware from '../services/authenticationHandler';
import server from '../index';
import request from 'supertest';
import config from '../config';
import sinon from 'sinon';

let fakeAuthenticationMiddleware: any;

describe('GET /oauth/bangumi', () => {
  it('should return 302 with Bangumi authorizationURL', () => {
    return request(server).get('/oauth/bangumi')
      .expect(302)
      .then((res: any) => {
        expect(res.header['location']).toMatch(config.passport.oauth.bangumi.authorizationURL);
      });
  });
});

describe('GET /oauth/bangumi/refresh', () => {

  afterAll(() => {
    sinon.restore();
  });

  it('should return 401 if unauthorized', () => {
    return request(server).post('/oauth/bangumi/refresh', {})
      .expect(401);
  });

  it('should return 400 if authorized but data cannot be verified', () => {
    fakeAuthenticationMiddleware = sinon.stub(authenticationMiddleware, 'isAuthenticated').callsFake(
      (req: any, res: any, next: any) => {
        return next();
      },
    );
    return request(server).post('/oauth/bangumi/refresh')
      .send({dummy: 'dummy'})
      .expect(400);
  });

});
