import {BackToTopModule} from './back-to-top.module';

describe('BackToTopModule', () => {
  let backToTopModule: BackToTopModule;

  beforeEach(() => {
    backToTopModule = new BackToTopModule();
  });

  it('should create an instance', () => {
    expect(backToTopModule).toBeTruthy();
  });
});
