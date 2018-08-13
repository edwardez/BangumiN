import {BanguminSearchModule} from './bangumin-search.module';

describe('BanguminSearchModule', () => {
  let searchModule: BanguminSearchModule;

  beforeEach(() => {
    searchModule = new BanguminSearchModule();
  });

  it('should create an instance', () => {
    expect(searchModule).toBeTruthy();
  });
});
