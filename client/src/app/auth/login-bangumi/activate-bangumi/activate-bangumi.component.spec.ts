import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ActivateBangumiComponent } from './activate-bangumi.component';

describe('ActivateBangumiComponent', () => {
  let component: ActivateBangumiComponent;
  let fixture: ComponentFixture<ActivateBangumiComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ActivateBangumiComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ActivateBangumiComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
