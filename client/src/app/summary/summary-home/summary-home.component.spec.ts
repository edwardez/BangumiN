import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {SummaryHomeComponent} from './summary-home.component';

describe('SummaryHomeComponent', () => {
  let component: SummaryHomeComponent;
  let fixture: ComponentFixture<SummaryHomeComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [SummaryHomeComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SummaryHomeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
