import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {SpoilerSingleContentComponent} from './spoiler-single-content.component';

describe('SpoilerSingleContentComponent', () => {
  let component: SpoilerSingleContentComponent;
  let fixture: ComponentFixture<SpoilerSingleContentComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [SpoilerSingleContentComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SpoilerSingleContentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
