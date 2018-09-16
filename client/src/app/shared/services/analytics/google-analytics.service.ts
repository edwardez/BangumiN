import {Injectable} from '@angular/core';
import {Subject, Subscription} from 'rxjs';
import {NavigationEnd, Router} from '@angular/router';
import {takeUntil} from 'rxjs/operators';
import {environment} from '../../../../environments/environment';

// taken from https://www.geekcafe.com/angular/2018/02/28/add-google-analytics-to-your-angular-spa-app-in-a-few-simple-steps/
// updated from g-analytics to gtag.ts

// --- use a declare to allow the compiler find the ga function
declare let gtag: Function;

@Injectable({
  providedIn: 'root'
})
export class GoogleAnalyticsService {
  private subscription: Subscription;
  private ngUnsubscribe: Subject<void> = new Subject<void>();

  constructor(private router: Router) {
  }

  public subscribe() {
    if (!this.subscription) {
      // subscribe to any router navigation and once it ends, write out the google script notices
      this.subscription = this.router.events
        .pipe(
          takeUntil(this.ngUnsubscribe)
        )
        .subscribe(e => {
          if (e instanceof NavigationEnd) {
            // https://developers.google.com/analytics/devguides/collection/gtagjs/single-page-applications
            gtag('config', environment.googleAnalyticsTrackingId, {'page_path': e.urlAfterRedirects});
          }
        });
    }
  }

  public unsubscribe() {
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

}
