/**
 * `HttpXsrfTokenExtractor` which retrieves the token from a cookie.
 */
import {Injectable} from '@angular/core';
import {HttpEvent, HttpHandler, HttpInterceptor, HttpRequest, HttpXsrfTokenExtractor} from '@angular/common/http';
import {Observable} from 'rxjs';

import {environment} from '../../../../environments/environment';

@Injectable()
export class CustomXsrfInterceptor implements HttpInterceptor {

  readonly backEndUrl = environment.BACKEND_URL.toLowerCase();
  readonly XSRF_HEADER_NAME = 'x-xsrf-token';

  constructor(private tokenExtractor: HttpXsrfTokenExtractor) {
  }

  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    const lcUrl = req.url.toLowerCase();
    const xsrfToken = this.tokenExtractor.getToken() as string;
    if (req.method !== 'GET' && req.method !== 'HEAD' && xsrfToken !== null && !req.headers.has(this.XSRF_HEADER_NAME) &&
      lcUrl.startsWith(this.backEndUrl)) {
      req = req.clone({headers: req.headers.set(this.XSRF_HEADER_NAME, xsrfToken)});
    }
    return next.handle(req);
  }

}
