import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {SubjectComponent} from './subject.component';

describe('SubjectComponent', () => {
  let component: SubjectComponent;
  let fixture: ComponentFixture<SubjectComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [SubjectComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SubjectComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
