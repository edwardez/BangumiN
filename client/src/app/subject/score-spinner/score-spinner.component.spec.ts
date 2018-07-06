import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {ScoreSpinnerComponent} from './score-spinner.component';

describe('ScoreSpinnerComponent', () => {
  let component: ScoreSpinnerComponent;
  let fixture: ComponentFixture<ScoreSpinnerComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ScoreSpinnerComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ScoreSpinnerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
