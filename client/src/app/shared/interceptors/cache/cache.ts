import {HttpRequest, HttpResponse} from '@angular/common/http';

export abstract class Cache {
  abstract get(req: HttpRequest<any>): HttpResponse<any> | null;

  abstract put(req: HttpRequest<any>, res: HttpResponse<any>): void;
}
