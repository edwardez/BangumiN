import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {environment} from '../../../../environments/environment';
import {switchMap, take} from 'rxjs/operators';
import {BanguminUserService} from './bangumin-user.service';
import {BanguminUserSchema} from '../../models/user/BanguminUser';
import {SpoilerNew} from '../../models/spoiler/spoiler-new';
import {Observable} from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class BanguminSpoilerService {

  constructor(
    private banguminUserService: BanguminUserService,
    private http: HttpClient) {
  }

  /**
   * create new spoiler
   * @param newSpoiler new spoiler
   */
  public postNewSpoiler(newSpoiler: any): Observable<any> {
    const options = {withCredentials: true};
    return this.banguminUserService.userSubject.pipe(
      take(1),
      switchMap((userSubject: BanguminUserSchema) =>
        this.http.post(`${environment.BACKEND_API_URL}/user/${userSubject.id}/spoiler`, new SpoilerNew().deserialize(newSpoiler), options))
    );
    //
  }

  /**
   * get spoiler according to spoilerId
   * @param newSpoiler new spoiler
   */
  public getSpoiler(userId: string, spoilerId: string): Observable<any> {
    const options = {withCredentials: true};
    // console.log(new SpoilerNew().deserialize(newSpoiler));
    // throw 's';
    return this.http.get(`${environment.BACKEND_API_URL}/user/${userId}/spoiler/${spoilerId}`, options);
    //
  }
}
