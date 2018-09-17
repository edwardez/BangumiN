import {LoadingSpinnerModule} from './loading-spinner.module';

describe('LoadingSpinnerModule', () => {
  let loadingSpinnerModule: LoadingSpinnerModule;

  beforeEach(() => {
    loadingSpinnerModule = new LoadingSpinnerModule();
  });

  it('should create an instance', () => {
    expect(loadingSpinnerModule).toBeTruthy();
  });
});
