import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SubjectSpoilerCreationComponent } from './subject-spoiler-creation.component';

describe('SubjectSpoilerCreationComponent', () => {
  let component: SubjectSpoilerCreationComponent;
  let fixture: ComponentFixture<SubjectSpoilerCreationComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SubjectSpoilerCreationComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SubjectSpoilerCreationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
