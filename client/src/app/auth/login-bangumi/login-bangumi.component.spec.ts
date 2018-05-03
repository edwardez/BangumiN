import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { LoginBangumiComponent } from './login-bangumi.component';
import {MaterialLayoutCommonModule} from '../../../material-layout-common.module';

describe('LoginBangumiComponent', () => {
  let component: LoginBangumiComponent;
  let fixture: ComponentFixture<LoginBangumiComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      imports: [
        MaterialLayoutCommonModule
      ],
      declarations: [ LoginBangumiComponent ],
      providers: [

      ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LoginBangumiComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
