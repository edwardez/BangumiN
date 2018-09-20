import {SubjectStatisticsModule} from './subject-statistics.module';

describe('SubjectStatisticsModule', () => {
  let subjectStatisticsModule: SubjectStatisticsModule;

  beforeEach(() => {
    subjectStatisticsModule = new SubjectStatisticsModule();
  });

  it('should create an instance', () => {
    expect(subjectStatisticsModule).toBeTruthy();
  });
});
