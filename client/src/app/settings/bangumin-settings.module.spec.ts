import {BanguminSettingsModule} from './bangumin-settings.module';

describe('BanguminSettingsModule', () => {
  let settingsModule: BanguminSettingsModule;

  beforeEach(() => {
    settingsModule = new BanguminSettingsModule();
  });

  it('should create an instance', () => {
    expect(settingsModule).toBeTruthy();
  });
});
