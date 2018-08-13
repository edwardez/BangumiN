import {BanguminAuthModule} from './bangumin-auth.module';

describe('BanguminAuthModule', () => {
  let banguminAuthModule: BanguminAuthModule;

  beforeEach(() => {
    banguminAuthModule = new BanguminAuthModule();
  });

  it('should create an instance', () => {
    expect(banguminAuthModule).toBeTruthy();
  });
});
