import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {SpoilerDeletionConfirmationDialogComponent} from './spoiler-deletion-confirmation-dialog.component';

describe('SpoilerDeletionConfirmationDialogComponent', () => {
  let component: SpoilerDeletionConfirmationDialogComponent;
  let fixture: ComponentFixture<SpoilerDeletionConfirmationDialogComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [SpoilerDeletionConfirmationDialogComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SpoilerDeletionConfirmationDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
