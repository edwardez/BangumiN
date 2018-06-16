import { SharedPipeModule } from './shared-pipe.module';

describe('SharedPipeModule', () => {
  let sharedPipeModule: SharedPipeModule;

  beforeEach(() => {
    sharedPipeModule = new SharedPipeModule();
  });

  it('should create an instance', () => {
    expect(sharedPipeModule).toBeTruthy();
  });
});
