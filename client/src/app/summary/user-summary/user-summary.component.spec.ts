import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {UserSummaryComponent} from './user-summary.component';

describe('UserSummaryComponent', () => {
  let component: UserSummaryComponent;
  let fixture: ComponentFixture<UserSummaryComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [UserSummaryComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(UserSummaryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
