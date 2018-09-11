import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {environment} from '../../../../environments/environment';
import {catchError, map, switchMap, take} from 'rxjs/operators';
import {BanguminUserService} from './bangumin-user.service';
import {BanguminUserSchema} from '../../models/user/BanguminUser';
import {RelatedSubjectsUserInput, SpoilerNew} from '../../models/spoiler/spoiler-new';
import {forkJoin, Observable, of, throwError as observableThrowError} from 'rxjs';
import {BangumiUserService} from '../bangumi/bangumi-user.service';
import {BangumiSubjectService} from '../bangumi/bangumi-subject.service';
import {RuntimeConstantsService} from '../runtime-constants.service';
import {SubjectBase} from '../../models/subject/subject-base';
import {SpoilerExisted} from '../../models/spoiler/spoiler-existed';

@Injectable({
  providedIn: 'root'
})
export class BanguminSpoilerService {

  constructor(
    private banguminUserService: BanguminUserService,
    private bangumiUserService: BangumiUserService,
    private bangumiSubjectService: BangumiSubjectService,
    private http: HttpClient) {
  }

  /**
   * create new spoiler
   * @param newSpoiler new spoiler
   */
  public postNewSpoiler(newSpoiler: any): Observable<SpoilerExisted> {
    const options = {withCredentials: true};
    return this.banguminUserService.userSubject.pipe(
      take(1),
      switchMap((userSubject: BanguminUserSchema) =>
        this.http.post<SpoilerExisted>
        (`${environment.BACKEND_API_URL}/user/${userSubject.id}/spoiler`, new SpoilerNew().deserialize(newSpoiler), options)),
      map(spoilerExisted => new SpoilerExisted().deserialize(spoilerExisted)),
    );
  }

  /**
   * get all spoilers under a userId
   * @param userId user id
   * @param createdAtStart createdAt of spoiler should be newer than this value
   * @param createdAtEnd createdAt of spoiler should be older than this value
   * @return userSpoilersBasicInfo: object {lastKey: lastElement}
   */
  public getSpoilersBasicInfo(userId: number | string, createdAtStart = 0, createdAtEnd = Date.now()): Observable<any> {
    const options = {withCredentials: true};
    return this.http.get<SpoilerExisted[]>
    (`${environment.BACKEND_API_URL}/user/${userId}/spoilers?createdAtStart=${createdAtStart}&createdAtEnd=${createdAtEnd}`, options)
      .pipe(
        map(userSpoilersBasicInfo => {
          userSpoilersBasicInfo['spoilers'] =
            userSpoilersBasicInfo['spoilers'].map(userSpoiler => new SpoilerExisted().deserialize(userSpoiler));
          return userSpoilersBasicInfo;
        })
      );
  }

  /**
   * get spoiler basic info that's from a different user: user info and spoiler text content
   * @param userId user id
   * @param spoilerId spoiler id
   */
  public getSingleAlienSpoilerBasicInfo(userId: string, spoilerId: string): Observable<SpoilerExisted> {
    const options = {withCredentials: true};
    return this.http.get<SpoilerExisted>(`${environment.BACKEND_API_URL}/user/${userId}/spoiler/${spoilerId}`, options)
      .pipe(
        map(spoilerExisted => new SpoilerExisted().deserialize(spoilerExisted)),
        catchError(error => {
          if (error.status === 404) {
            return of(null);
          }
          throw observableThrowError(error);
        })
      );
  }

  public getSpoilerAllRelatedInfo(userId: string | number, relatedSubjects: RelatedSubjectsUserInput[]) {
    const requestAllObservables: {}[] = [this.bangumiUserService.getUserInfoFromHttp(userId)];
    // if there's no related subject, an empty array will be emitted
    requestAllObservables.push(this.getSpoilerRelatedSubjectInfo(relatedSubjects));

    return forkJoin(requestAllObservables);

  }

  public getSpoilerRelatedSubjectInfo(relatedSubjects: RelatedSubjectsUserInput[]) {
    const requestSubjectsObservables = relatedSubjects.map((relatedSubject) => {
      if (relatedSubject.id === RuntimeConstantsService.defaultSubjectId) {
        return of(new SubjectBase(relatedSubject.id, undefined, undefined, relatedSubject.name, relatedSubject.name));
      }

      return this.bangumiSubjectService.getSubject(relatedSubject.id, 'base');
    });

    // if there's no related subject, an empty array will be emitted
    return requestSubjectsObservables.length === 0 ? of([]) : forkJoin(requestSubjectsObservables);

  }


}
