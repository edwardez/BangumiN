import {Serializable} from '../Serializable';
import {SubjectBase} from './subject-base';
import {SubjectCollection} from './subject-collection';
import {Images} from '../common/images';


export class SubjectWatchingCollectionMedium extends SubjectBase implements Serializable<SubjectWatchingCollectionMedium> {
  /**
   * 话数
   * example: 27
   * format: int32
   */
  eps?: number;
  /**
   * 话数
   * example: 27
   * format: int32
   */
  eps_count?: number;

  images?: Images;

  collection?: SubjectCollection; // seems like only 'doing' is returned?

  constructor() {
    super();
    this.eps = 0;
    this.eps_count = 0;
    this.collection = new SubjectCollection();
    this.images = new Images();
  }

  deserialize(input) {
    super.deserialize(input);
    this.eps = input.episodes || 0;
    this.eps_count = input.eps_count || 0;
    this.collection = input.collection ===  undefined ? new SubjectCollection() : new SubjectCollection().deserialize(input.collection);
    this.images = input.images === undefined ? new Images() : new Images().deserialize(input.images);
    return this;
  }
}
