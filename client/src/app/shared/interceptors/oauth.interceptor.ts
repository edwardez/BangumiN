import {Injectable} from '@angular/core';
import {HttpErrorResponse, HttpEvent, HttpHandler, HttpInterceptor, HttpRequest} from '@angular/common/http';
import {Observable} from 'rxjs';
import {catchError, filter, finalize, switchMap, take} from 'rxjs/operators';
import {throwError} from 'rxjs/internal/observable/throwError';
import {AuthenticationService} from '../services/auth.service';
import {BehaviorSubject} from 'rxjs/internal/BehaviorSubject';
import {throwError as observableThrowError} from 'rxjs/index';


@Injectable()
export class OauthInterceptor implements HttpInterceptor {
  isRefreshingToken = false;
  tokenSubject: BehaviorSubject<string> = new BehaviorSubject<string>(null);

  static addToken(request: HttpRequest<any>, accessToken: string): HttpRequest<any> {
    return request.clone({
      setHeaders: {
        'Authorization': `Bearer ${accessToken}`
      },
      withCredentials: false
    });
  }

  intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    // if it IS in blacklisted route, in our case, a bangumi route
    // attach bangumi access token to the header
    request = request.clone();

    return next.handle(request).pipe(
      catchError(error => {
        if (error instanceof HttpErrorResponse && (<HttpErrorResponse>error).status === 401) {
          return this.handle401Error(request, next);
        } else {
          return throwError(error);
        }
      })
    );
  }


  handle401Error(request: HttpRequest<any>, next: HttpHandler) {
    if (!this.isRefreshingToken) {
      this.isRefreshingToken = true;

      // Reset here so that the following requests wait until the token
      // comes back from the refreshToken call.
      this.tokenSubject.next(null);

      return this.authenticationService.refreshBangumiOauthToken()
        .pipe(
          take(1),
          switchMap(bangumiRefreshTokenResponse => {
            const newAccessToken = bangumiRefreshTokenResponse.accessToken;
            if (newAccessToken !== undefined && bangumiRefreshTokenResponse.refreshToken !== undefined) {
              this.tokenSubject.next(newAccessToken);
              return next.handle(OauthInterceptor.addToken(request, newAccessToken));
            } else {
              this.authenticationService.logoutWithMessage('error.unauthorized');
            }

          }),
          catchError(err => {
            this.authenticationService.logoutWithMessage('error.unauthorized');
            return observableThrowError(err);
          }),
          finalize(() => {
            this.isRefreshingToken = false;
          })
        );
    } else {
      return this.tokenSubject
        .pipe(
          filter(token => token != null),
          take(1),
          switchMap(token => {
            return next.handle(OauthInterceptor.addToken(request, token));
          })
        );
    }

  }


  constructor(private authenticationService: AuthenticationService) {
  }

}
