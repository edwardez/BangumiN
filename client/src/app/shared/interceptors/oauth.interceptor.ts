import {Injectable} from '@angular/core';
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor
} from '@angular/common/http';
import {Observable} from 'rxjs';
import {environment} from '../../../environments/environment';
import {parse} from 'url';


@Injectable()
export class OauthInterceptor implements HttpInterceptor {
  intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    const accessToken = localStorage.getItem('accessToken');
    // if it IS in blacklisted route, in our case, a bangumi route
    // attach bangumi access token to the header
    if (this.isBlacklistedRoute(request) && accessToken) {
      request = request.clone({
        setHeaders: {
          'Authorization': `Bearer ${accessToken}`
        }
      });
    } else {
      request = request.clone();
    }

    return next.handle(request);
  }

  isWhitelistedDomain(request: HttpRequest<any>): boolean {
    const whitelistedDomains: Array<string | RegExp> = environment.whitelistedDomains;
    const requestUrl = parse(request.url, false, true);

    return (
      whitelistedDomains.findIndex(
        domain =>
          typeof domain === 'string'
            ? domain === requestUrl.host
            : domain instanceof RegExp ? domain.test(requestUrl.host) : false
      ) > -1
    );
  }

  isBlacklistedRoute(request: HttpRequest<any>): boolean {
    const blacklistedRoutes: Array<string | RegExp> = environment.blacklistedRoutes;
    const url = request.url;

    return (
      blacklistedRoutes.findIndex(
        route =>
          typeof route === 'string'
            ? route === url
            : route instanceof RegExp ? route.test(url) : false
      ) > -1
    );
  }


  constructor() {
  }

}
