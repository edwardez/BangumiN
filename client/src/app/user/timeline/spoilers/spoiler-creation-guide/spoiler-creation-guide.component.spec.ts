import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {SpoilerCreationGuideComponent} from './spoiler-creation-guide.component';

describe('SpoilerCreationGuideComponent', () => {
  let component: SpoilerCreationGuideComponent;
  let fixture: ComponentFixture<SpoilerCreationGuideComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [SpoilerCreationGuideComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SpoilerCreationGuideComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
