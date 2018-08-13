import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {ProgessBySubjectComponent} from './progess-by-subject.component';

describe('ProgessBySubjectComponent', () => {
  let component: ProgessBySubjectComponent;
  let fixture: ComponentFixture<ProgessBySubjectComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ProgessBySubjectComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ProgessBySubjectComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
