import { StarRatingModule } from './star-rating.module';

describe('StarRatingModule', () => {
  let starRatingModule: StarRatingModule;

  beforeEach(() => {
    starRatingModule = new StarRatingModule();
  });

  it('should create an instance', () => {
    expect(starRatingModule).toBeTruthy();
  });
});
