import {SubjectCount} from './subject-count';
import {Serializable} from '../Serializable';

export class SubjectCollection implements Serializable<SubjectCollection> {
  /**
   * 想做
   * example: 608
   * format: int32
   */
  wish?: number;
  /**
   * 做过
   * example: 3010
   * format: int32
   */
  collect?: number;
  /**
   * 在做
   * example: 103
   * format: int32
   */
  doing?: number;
  /**
   * 搁置
   * example: 284
   * format: int32
   */
  on_hold?: number;
  /**
   * 抛弃
   * example: 86
   * format: int32
   */
  dropped?: number;

  SubjectCollection() {
    this.wish = 0;
    this.collect = 0;
    this.doing = 0;
    this.on_hold = 0;
    this.dropped = 0;
  }

  deserialize(input) {
    this.wish = input.wish === undefined ? 0 : input.wish;
    this.collect = input.collect === undefined ? 0 : input.collect;
    this.doing = input.doing === undefined ? 0 : input.doing;
    this.on_hold = input.on_hold === undefined ? 0 : input.on_hold;
    this.dropped = input.dropped === undefined ? 0 : input.dropped;
    return this;
  }
}
