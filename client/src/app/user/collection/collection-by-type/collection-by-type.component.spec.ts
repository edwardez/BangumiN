import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {CollectionByTypeComponent} from './collection-by-type.component';

describe('CollectionByTypeComponent', () => {
  let component: CollectionByTypeComponent;
  let fixture: ComponentFixture<CollectionByTypeComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [CollectionByTypeComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CollectionByTypeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
