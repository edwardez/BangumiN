import {Component, OnInit} from '@angular/core';
import {environment} from '../../../environments/environment';

@Component({
  selector: 'app-login-bangumi',
  templateUrl: './login-bangumi.component.html',
  styleUrls: ['./login-bangumi.component.scss']
})
export class LoginBangumiComponent implements OnInit {

  bangumi_oauth_redirect = `${environment.BACKEND_OAUTH_REDIRECT_URL}/bangumi`;

  constructor() {

  }

  ngOnInit() {
  }

}
