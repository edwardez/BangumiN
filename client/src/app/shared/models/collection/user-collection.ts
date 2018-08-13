import {Serializable} from '../Serializable';
import {CollectionResponse} from './collection-response';
import {SubjectType} from '../../enums/subject-type.enum';
import {CollectionStatus} from './collection-status';
import {SubjectBase} from '../subject/subject-base';
import {CollectionStatusId} from '../../enums/collection-status-id';

export class UserCollection implements Serializable<UserCollection> {

  status?: CollectionStatus;
  count?: number;
  collectionUnderCurrentStatus?: SubjectBase[];

  deserialize(input): CollectionResponse {
    this.status = input.status || CollectionStatusId.untouched;
    this.count = input.count || 0;
    this.collectionUnderCurrentStatus = input.list === undefined ?
      [] : input.list.map(currentSubject => new SubjectBase().deserialize((currentSubject.subject)));
    return this;
  }

}
