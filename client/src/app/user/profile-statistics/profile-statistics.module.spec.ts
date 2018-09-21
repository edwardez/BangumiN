import {ProfileStatisticsModule} from './profile-statistics.module';

describe('ProfileStatisticsModule', () => {
  let profileStatsModule: ProfileStatisticsModule;

  beforeEach(() => {
    profileStatsModule = new ProfileStatisticsModule();
  });

  it('should create an instance', () => {
    expect(profileStatsModule).toBeTruthy();
  });
});
