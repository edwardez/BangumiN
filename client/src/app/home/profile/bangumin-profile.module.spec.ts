import {BanguminProfileModule} from './bangumin-profile.module';

describe('BanguminProfileModule', () => {
  let profileModule: BanguminProfileModule;

  beforeEach(() => {
    profileModule = new BanguminProfileModule();
  });

  it('should create an instance', () => {
    expect(profileModule).toBeTruthy();
  });
});
