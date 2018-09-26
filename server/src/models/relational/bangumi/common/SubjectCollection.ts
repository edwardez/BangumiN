export interface SubjectCollection {
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
}
