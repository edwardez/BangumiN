import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {UserSearchCardContentComponent} from './user-search-card-content.component';

describe('UserSearchCardContentComponent', () => {
  let component: UserSearchCardContentComponent;
  let fixture: ComponentFixture<UserSearchCardContentComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [UserSearchCardContentComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(UserSearchCardContentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
