import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SingleSubjectComponent } from './single-subject.component';

describe('SingleSubjectComponent', () => {
  let component: SingleSubjectComponent;
  let fixture: ComponentFixture<SingleSubjectComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SingleSubjectComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SingleSubjectComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
