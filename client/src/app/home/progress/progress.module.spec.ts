import { ProgressModule } from './progress.module';

describe('ProgressModule', () => {
  let progressModule: ProgressModule;

  beforeEach(() => {
    progressModule = new ProgressModule();
  });

  it('should create an instance', () => {
    expect(progressModule).toBeTruthy();
  });
});
