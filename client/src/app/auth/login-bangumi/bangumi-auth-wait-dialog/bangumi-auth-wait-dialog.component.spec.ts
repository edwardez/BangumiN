import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { BangumiAuthWaitDialogComponent } from './bangumi-auth-wait-dialog.component';

describe('BangumiAuthWaitDialogComponent', () => {
  let component: BangumiAuthWaitDialogComponent;
  let fixture: ComponentFixture<BangumiAuthWaitDialogComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ BangumiAuthWaitDialogComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(BangumiAuthWaitDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
