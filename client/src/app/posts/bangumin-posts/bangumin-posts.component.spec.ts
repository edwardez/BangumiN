import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {BanguminPostsComponent} from './bangumin-posts.component';

describe('BanguminPostsComponent', () => {
  let component: BanguminPostsComponent;
  let fixture: ComponentFixture<BanguminPostsComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [BanguminPostsComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(BanguminPostsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
