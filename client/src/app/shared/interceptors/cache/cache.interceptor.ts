import {CacheMapService} from './cache-map.service';
import {HttpHandler, HttpInterceptor, HttpRequest, HttpResponse} from '@angular/common/http';
import {of} from 'rxjs';
import {tap} from 'rxjs/operators';
import {Injectable} from '@angular/core';
import {RuntimeConstantsService} from '../../services/runtime-constants.service';

@Injectable({
  providedIn: 'root'
})
export class CacheInterceptor implements HttpInterceptor {


  constructor(private cache: CacheMapService) {
  }

  static isCacheableUrl(request: HttpRequest<any>) {
    const url = request.url;
    return !(RuntimeConstantsService.nonCacheableUrls.findIndex(function (route) {
      return typeof route === 'string'
        ? route === url
        : route.test(url);
    }) > -1);
  }

  static isRequestCacheable(req: HttpRequest<any>) {
    return (req.method === 'GET' && this.isCacheableUrl(req));
  }

  intercept(req: HttpRequest<any>, next: HttpHandler) {
    if (!CacheInterceptor.isRequestCacheable(req)) {
      return next.handle(req);
    }
    const cachedResponse = this.cache.get(req);
    if (cachedResponse !== null) {
      return of(cachedResponse);
    }
    return next.handle(req).pipe(
      tap(event => {
        if (event instanceof HttpResponse) {
          this.cache.put(req, event);
        }
      })
    );
  }


}
