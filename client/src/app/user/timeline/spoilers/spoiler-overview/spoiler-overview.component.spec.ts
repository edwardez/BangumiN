import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {SpoilerOverviewComponent} from './spoiler-overview.component';

describe('SpoilerOverviewComponent', () => {
  let component: SpoilerOverviewComponent;
  let fixture: ComponentFixture<SpoilerOverviewComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [SpoilerOverviewComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SpoilerOverviewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
