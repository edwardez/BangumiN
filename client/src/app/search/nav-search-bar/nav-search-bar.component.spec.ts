import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {NavSearchBarComponent} from './nav-search-bar.component';

describe('NavSearchBarComponent', () => {
  let component: NavSearchBarComponent;
  let fixture: ComponentFixture<NavSearchBarComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [NavSearchBarComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(NavSearchBarComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
