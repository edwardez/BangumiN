import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {ProgressBySubjectComponent} from './progress-by-subject.component';

describe('ProgressBySubjectComponent', () => {
  let component: ProgressBySubjectComponent;
  let fixture: ComponentFixture<ProgressBySubjectComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ProgressBySubjectComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ProgressBySubjectComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
