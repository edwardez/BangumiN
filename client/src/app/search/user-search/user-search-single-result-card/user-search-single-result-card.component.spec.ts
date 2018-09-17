import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {UserSearchSingleResultCardComponent} from './user-search-single-result-card.component';

describe('UserSearchSingleResultCardComponent', () => {
  let component: UserSearchSingleResultCardComponent;
  let fixture: ComponentFixture<UserSearchSingleResultCardComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [UserSearchSingleResultCardComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(UserSearchSingleResultCardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
