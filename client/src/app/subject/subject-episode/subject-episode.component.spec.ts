import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {SubjectEpisodeComponent} from './subject-episode.component';

describe('SubjectEpisodeComponent', () => {
  let component: SubjectEpisodeComponent;
  let fixture: ComponentFixture<SubjectEpisodeComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [SubjectEpisodeComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SubjectEpisodeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
