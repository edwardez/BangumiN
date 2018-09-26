import {NavSearchBarModule} from './nav-search-bar.module';

describe('NavSearchBarModule', () => {
  let navSearchBarModule: NavSearchBarModule;

  beforeEach(() => {
    navSearchBarModule = new NavSearchBarModule();
  });

  it('should create an instance', () => {
    expect(navSearchBarModule).toBeTruthy();
  });
});
