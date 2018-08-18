import {SpoilersModule} from './spoilers.module';

describe('SpoilersModule', () => {
  let spoilersModule: SpoilersModule;

  beforeEach(() => {
    spoilersModule = new SpoilersModule();
  });

  it('should create an instance', () => {
    expect(spoilersModule).toBeTruthy();
  });
});
