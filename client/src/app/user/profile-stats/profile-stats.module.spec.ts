import {ProfileStatsModule} from './profile-stats.module';

describe('ProfileStatsModule', () => {
  let profileStatsModule: ProfileStatsModule;

  beforeEach(() => {
    profileStatsModule = new ProfileStatsModule();
  });

  it('should create an instance', () => {
    expect(profileStatsModule).toBeTruthy();
  });
});
