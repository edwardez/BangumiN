import {SubjectBase} from './subject-base';
import {SubjectCollection} from './subject-collection';
import {SubjectRating} from './subject-rating';
import {Serializable} from '../Serializable';

export class SubjectSmall extends SubjectBase implements Serializable<SubjectSmall> {
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
  rating?: SubjectRating;
  /**
   * 排名
   * example: 573
   * format: int32
   */
  rank?: number;
  collection?: SubjectCollection;

  deserialize(input) {
    super.deserialize(input);
    this.eps = input.episodes || [];
    this.eps_count = input.eps_count || null;
    this.rating = input.rating ? new SubjectRating().deserialize(input.rating) : new SubjectRating();
    this.rank = input.rank ? input.rank : '-';
    this.collection = input.collection ? new SubjectCollection().deserialize(input.collection) : new SubjectCollection();
    return this;
  }

}
