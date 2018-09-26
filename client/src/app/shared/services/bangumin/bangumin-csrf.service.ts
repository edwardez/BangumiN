import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {environment} from '../../../../environments/environment';
import {Observable} from 'rxjs';

export interface CsrfTokenSchema {
  csrfToken: string;
}

@Injectable({
  providedIn: 'root'
})
export class BanguminCsrfService {

  constructor(private http: HttpClient, ) { }

  public getCsrfToken(): Observable<CsrfTokenSchema> {
    return this.http.get<CsrfTokenSchema>(`${environment.BACKEND_AUTH_URL}/csrf/token`, {withCredentials: true});
  }
}
