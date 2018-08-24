import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {SpoilerCreationComponent} from './spoiler-creation.component';

describe('SpoilerCreationComponent', () => {
  let component: SpoilerCreationComponent;
  let fixture: ComponentFixture<SpoilerCreationComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [SpoilerCreationComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SpoilerCreationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
