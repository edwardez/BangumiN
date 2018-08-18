import {SpoilerSingleModule} from './spoiler-single.module';

describe('SpoilerSingleModule', () => {
  let spoilerSingleModule: SpoilerSingleModule;

  beforeEach(() => {
    spoilerSingleModule = new SpoilerSingleModule();
  });

  it('should create an instance', () => {
    expect(spoilerSingleModule).toBeTruthy();
  });
});
