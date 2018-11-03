import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { StopCrawlingExplanationDialogComponent } from './stop-crawling-explanation-dialog.component';

describe('StopCrawlingExplanationDialogComponent', () => {
  let component: StopCrawlingExplanationDialogComponent;
  let fixture: ComponentFixture<StopCrawlingExplanationDialogComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ StopCrawlingExplanationDialogComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(StopCrawlingExplanationDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
