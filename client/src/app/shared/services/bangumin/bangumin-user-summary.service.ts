import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {Observable, of} from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class BanguminUserSummaryService {

  constructor(private http: HttpClient) {
  }

  public getUserSummary(username: string): Observable<any> {
    return of({
      'userName': 'mock',
    });
  }
}
