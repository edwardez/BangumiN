import { HttpsPipe } from './https.pipe';

describe('HttpsPipe', () => {
  it('create an instance', () => {
    const pipe = new HttpsPipe();
    expect(pipe).toBeTruthy();
  });
});
