import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {environment} from '../../../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class BanguminUserService {

  constructor(private http: HttpClient) {
  }

  public updateUserSettings(settings: any): any {
    const options = {withCredentials: true};
    return this.http.post(`${environment.BACKEND_API_URL}/user/2/settings`, settings, options);
  }
}
