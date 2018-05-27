import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ProgressByTypeComponent } from './progress-by-type.component';

describe('ProgressByTypeComponent', () => {
  let component: ProgressByTypeComponent;
  let fixture: ComponentFixture<ProgressByTypeComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ProgressByTypeComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ProgressByTypeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
