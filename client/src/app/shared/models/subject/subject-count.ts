import {Serializable} from '../Serializable';

export class SubjectCount implements Serializable<SubjectCount> {
  /**
   * example: 5
   * format: int32
   */
  1?: number;
  /**
   * example: 3
   * format: int32
   */
  2?: number;
  /**
   * example: 4
   * format: int32
   */
  3?: number;
  /**
   * example: 6
   * format: int32
   */
  4?: number;
  /**
   * example: 46
   * format: int32
   */
  5?: number;
  /**
   * example: 267
   * format: int32
   */
  6?: number;
  /**
   * example: 659
   * format: int32
   */
  7?: number;
  /**
   * example: 885
   * format: int32
   */
  8?: number;
  /**
   * example: 284
   * format: int32
   */
  9?: number;
  /**
   * example: 130
   * format: int32
   */
  10?: number;

  SubjectCount() {
    this['1'] = 0;
    this['2'] = 0;
    this['3'] = 0;
    this['4'] = 0;
    this['5'] = 0;
    this['6'] = 0;
    this['7'] = 0;
    this['8'] = 0;
    this['9'] = 0;
    this['10'] = 0;
  }

  deserialize(input) {
    this['1'] = input['1'] || 0;
    this['2'] = input['2'] || 0;
    this['3'] = input['3'] || 0;
    this['4'] = input['4'] || 0;
    this['5'] = input['5'] || 0;
    this['6'] = input['6'] || 0;
    this['7'] = input['7'] || 0;
    this['8'] = input['8'] || 0;
    this['9'] = input['9'] || 0;
    this['10'] = input['10'] || 0;
    return this;
  }
}
