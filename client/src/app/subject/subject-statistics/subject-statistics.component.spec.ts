import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {SubjectStatisticsComponent} from './subject-statistics.component';

describe('SubjectStatisticsComponent', () => {
  let component: SubjectStatisticsComponent;
  let fixture: ComponentFixture<SubjectStatisticsComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [SubjectStatisticsComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SubjectStatisticsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
