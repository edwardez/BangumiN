/**
 * `HttpXsrfTokenExtractor` which retrieves the token from a cookie.
 */
import {Injectable} from '@angular/core';
import {HttpErrorResponse, HttpEvent, HttpHandler, HttpInterceptor, HttpRequest} from '@angular/common/http';
import {Observable, throwError} from 'rxjs';

import {environment} from '../../../../environments/environment';
import {SnackBarService} from '../../services/snackBar/snack-bar.service';
import {catchError} from 'rxjs/operators';
import {BanguminErrorCode} from '../../enums/bangumin-error-code';

@Injectable()
export class ErrorNotificationInterceptor implements HttpInterceptor {

  readonly backEndUrl = environment.BACKEND_URL.toLowerCase();
  // A list of error code, that user should be notified
  readonly shouldNotifyUserBanguminErrorCodes: number[] =
    Object.keys(BanguminErrorCode)
      .filter((banguminErrorCode: string) => {
        const numericCode = Number(banguminErrorCode);
        console.log(numericCode);
        return !isNaN(numericCode) && numericCode !== BanguminErrorCode.UnclassifiedInternalError;
      })
      .map(k => Number(k));

  constructor(private snackBarService: SnackBarService) {
  }

  // safely access error code
  static getErrorCode(error: HttpErrorResponse): BanguminErrorCode {
    const httpErrorResponse = error || {error: {code: BanguminErrorCode.UnclassifiedInternalError}};
    const errorObject = httpErrorResponse.error || {code: BanguminErrorCode.UnclassifiedInternalError};
    return errorObject.code || BanguminErrorCode.UnclassifiedInternalError;
  }

  static mapErrorCodeToTranslationLabel(banguminErrorCode: BanguminErrorCode): string {
    switch (banguminErrorCode) {
      case BanguminErrorCode.UnclassifiedInternalError:
        return 'error.httpResponse.UnclassifiedInternalError';
      case BanguminErrorCode.ValidationError:
        return 'error.httpResponse.ValidationError';
      case BanguminErrorCode.BangumiServerResponseError:
        return 'error.httpResponse.BangumiServerResponseError';
      case BanguminErrorCode.RequestResourceNotFoundError:
        return 'error.httpResponse.RequestResourceNotFoundError';
      case BanguminErrorCode.RDSResponseError:
        return 'error.httpResponse.RDSResponseError';
      case BanguminErrorCode.NoSQLResponseError:
        return 'error.httpResponse.NoSQLResponseError';
      case BanguminErrorCode.UnauthorizedError:
        return 'error.httpResponse.UnauthorizedError';
      default:
        return 'error.httpResponse.UnclassifiedInternalError';
    }
  }

  intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    return next.handle(request).pipe(
      catchError(error => {
          if (error instanceof HttpErrorResponse) {
            this.checkAndDetermineErrorNotificationType(error, request, next);
            return throwError(error);
          }
        }
      )
    );
  }

  /**
   * Check the error type and pop up snack bar message if possible
   * @param error HttpErrorResponse
   * @param request HttpRequest
   * @param next HttpHandler
   */
  checkAndDetermineErrorNotificationType(error: HttpErrorResponse, request: HttpRequest<any>, next: HttpHandler) {
    const lcUrl = request.url.toLowerCase();
    if (error && lcUrl.startsWith(this.backEndUrl)) {
      // if request type is not get/head/options: user is trying to modify something, always show error snack bar
      if (request.method !== 'GET' && request.method !== 'HEAD' && request.method !== 'OPTIONS') {
        const errorCode = ErrorNotificationInterceptor.getErrorCode(error);
        this.createWarnSnackBar(errorCode);
      } else if (error && error.error && error.error.code && this.shouldNotifyUserBanguminErrorCodes.indexOf(error.error.code) !== -1) {
        // else, even if request type is not get/head/options, if it's an known error, a snackbar will still be shown
        this.createWarnSnackBar(error.error.code);
      }
    }

  }

  createWarnSnackBar(errorCode: BanguminErrorCode) {
    this.snackBarService.openSimpleSnackBar(ErrorNotificationInterceptor.mapErrorCodeToTranslationLabel(errorCode), undefined,
      {duration: 6000, panelClass: 'warn-color'}).subscribe();
  }


}
