import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {SpoilerSingleWrapperComponent} from './spoiler-single-wrapper.component';

describe('SpoilerSingleWrapperComponent', () => {
  let component: SpoilerSingleWrapperComponent;
  let fixture: ComponentFixture<SpoilerSingleWrapperComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [SpoilerSingleWrapperComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SpoilerSingleWrapperComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
