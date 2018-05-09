import {CollectionStatusId} from '../../enums/collection-status-id';
import {CollectionStatusType} from '../../enums/collection-status-type';
import {Serializable} from '../Serializable';

export class CollectionStatus implements Serializable<CollectionStatus> {
  id?: CollectionStatusId;
  type?: CollectionStatusType;
  name?: string; // no need to create enum for this field since it's unused
  isTouched?: boolean;

  static isTouched(id: CollectionStatusId) {
    return [
      CollectionStatusId.collect,
      CollectionStatusId.do,
      CollectionStatusId.dropped,
      CollectionStatusId.on_hold,
      CollectionStatusId.wish].indexOf(id) !== -1;
  }

  constructor() {
    this.id = CollectionStatusId.untouched;
    this.type = CollectionStatusType['untouched'];
    this.name = '';
    this.isTouched = CollectionStatus.isTouched(this.id);
  }

  deserialize(input): CollectionStatus {
    this.id = input.id === undefined ? CollectionStatusId.untouched : input.id;
    this.type = input.type === undefined ? CollectionStatusType.untouched : input.type;
    this.name = input.name === undefined ? '' : input.name;
    this.isTouched = CollectionStatus.isTouched(this.id);

    return this;
  }



}
