import {Component, OnDestroy, OnInit} from '@angular/core';
import {ActivatedRoute, Router} from '@angular/router';
import {AuthenticationService} from '../../../shared/services/auth.service';
import {takeUntil} from 'rxjs/operators';
import {Subject} from 'rxjs/Subject';

@Component({
  selector: 'app-activate-bangumi',
  templateUrl: './activate-bangumi.component.html',
  styleUrls: ['./activate-bangumi.component.scss']
})
export class ActivateBangumiComponent implements OnInit, OnDestroy {
  private ngUnsubscribe: Subject<void> = new Subject<void>();

  constructor(private route: ActivatedRoute,
              private router: Router,
              private authService: AuthenticationService) { }

  ngOnInit() {
    this.route
      .queryParams
      .subscribe(params => {
        // Defaults to 0 if no query param provided.
        if (params['access_token'] && params['type'] === 'bangumi') {
          this.authService.verifyAccessToken(params['access_token'])
            .pipe(takeUntil(this.ngUnsubscribe))
            .subscribe( response => {
              console.log(response);
          }, err => {
              console.log(err);
          });
        }
      });


  }

  ngOnDestroy(): void {
    // unsubscribe, we can also first() in subscription
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

}

