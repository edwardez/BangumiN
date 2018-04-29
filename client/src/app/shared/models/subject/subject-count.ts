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

  deserialize(input) {
    this['1'] = input['1'];
    this['2'] = input['2'];
    this['3'] = input['3'];
    this['4'] = input['4'];
    this['5'] = input['5'];
    this['6'] = input['6'];
    this['7'] = input['7'];
    this['8'] = input['8'];
    this['9'] = input['9'];
    this['10'] = input['10'];
    return this;
  }
}
