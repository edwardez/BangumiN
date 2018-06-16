import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {ProgressPlaceholderComponent} from './progress-placeholder.component';

describe('ProgressPlaceholderComponent', () => {
  let component: ProgressPlaceholderComponent;
  let fixture: ComponentFixture<ProgressPlaceholderComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ProgressPlaceholderComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ProgressPlaceholderComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
