import { BanguminSubjectModule } from './bangumin-subject.module';

describe('BanguminSubjectModule', () => {
  let banguminSubjectModule: BanguminSubjectModule;

  beforeEach(() => {
    banguminSubjectModule = new BanguminSubjectModule();
  });

  it('should create an instance', () => {
    expect(banguminSubjectModule).toBeTruthy();
  });
});
