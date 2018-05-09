import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { FullSearchComponent } from './full-search.component';

describe('FullSearchComponent', () => {
  let component: FullSearchComponent;
  let fixture: ComponentFixture<FullSearchComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ FullSearchComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FullSearchComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
