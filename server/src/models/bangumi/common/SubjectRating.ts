import {SubjectCount} from './SubjectCount';

export interface SubjectRating {
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
}