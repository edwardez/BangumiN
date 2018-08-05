import server from '../index';
import request from 'supertest';

describe('GET /auth/token', () => {
  it('should return 401 if unauthorized', () => {
    return request(server).post('/auth/token', {})
      .expect(401);
  });
});
