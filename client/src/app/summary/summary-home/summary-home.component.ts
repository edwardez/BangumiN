import {Component, OnDestroy, OnInit} from '@angular/core';
import {NavBarService} from '../../shared/services/navbar/nav-bar.service';
import {ActivatedRoute, Router} from '@angular/router';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import {BanguminUserSummaryService} from '../../shared/services/bangumin/bangumin-user-summary.service';
import {BangumiUserService} from '../../shared/services/bangumi/bangumi-user.service';

@Component({
  selector: 'app-summary-home',
  templateUrl: './summary-home.component.html',
  styleUrls: ['./summary-home.component.scss']
})
export class SummaryHomeComponent implements OnInit, OnDestroy {

  username: any;
  requestedUserForm: FormGroup;

  constructor(
    private activatedRoute: ActivatedRoute,
    private bangumiUserService: BangumiUserService,
    private banguminUserSummaryService: BanguminUserSummaryService,
    private formBuilder: FormBuilder,
    private navBarService: NavBarService,
    private router: Router) {

  }

  get userNameOrHomeUrl() {
    return this.requestedUserForm.get('userNameOrHomeUrl');
  }

  submitRequestedUserForm() {
    console.log(this.requestedUserForm.get('userNameOrHomeUrl').value);
    const usernameOnForm = this.requestedUserForm.get('userNameOrHomeUrl').value;
    this.checkIfUserExists(usernameOnForm);
  }

  checkIfUserExists(userNameToSearch: string) {
    this.bangumiUserService.getUserInfoFromHttp(userNameToSearch).subscribe(userInfo => {
      if (userInfo && userInfo.id) {
        this.username = userInfo.username;
      } else {
        console.error('no such user');
      }
    });
  }

  ngOnInit() {
    setTimeout(() => {
      this.navBarService.hide();
    }, 0);
    this.requestedUserForm = this.formBuilder.group(
      {
        'userNameOrHomeUrl': ['', Validators.maxLength(5)]
      }
    );
    this.activatedRoute.params.subscribe(params => {
      if (params && params['userId']) {
        this.checkIfUserExists(params['userId']);
      }
    });

  }

  ngOnDestroy() {
    this.navBarService.show();
    // setTimeout(()=>{
    //
    // }, 0);
  }

}
