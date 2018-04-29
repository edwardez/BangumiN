import {SubjectCount} from './subject-count';
import {Serializable} from '../Serializable';

export class SubjectRating implements Serializable<SubjectRating> {
  /**
   * 总评分人数
   * example: 2289
   * format: int32
   */
  total?: number;
  count?: SubjectCount;
  /**
   * 评分
   * example: 7.6
   * format: double
   */
  score?: number;

  deserialize(input) {
    this.total = input.total;
    this.count = new SubjectCount().deserialize(input.count);
    this.score = input.score;
    return this;
  }
}
