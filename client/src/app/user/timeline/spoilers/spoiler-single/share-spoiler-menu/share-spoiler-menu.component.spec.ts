import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {ShareSpoilerMenuComponent} from './share-spoiler-menu.component';

describe('ShareSpoilerMenuComponent', () => {
  let component: ShareSpoilerMenuComponent;
  let fixture: ComponentFixture<ShareSpoilerMenuComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ShareSpoilerMenuComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ShareSpoilerMenuComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
