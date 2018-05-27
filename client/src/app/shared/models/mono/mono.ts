import {Serializable} from '../Serializable';
import {Images} from '../common/images';

export class Mono implements Serializable<Mono> {
  /**
   * 人物 ID
   * format: int32
   */
  id?: number;
  /** 人物地址 */
  url?: string;
  /** 姓名 */
  name?: string;
  images?: Images;
  /** 简体中文名 */
  name_cn?: string;
  /**
   * 回复数量
   * format: int32
   */
  comment?: number;
  /**
   * 收藏人数
   * format: int32
   */
  collects?: number;

  deserialize(input) {
    this.id = input.id;
    this.url = input.url;
    this.name = input.name;
    this.name_cn = input.name_cn;
    this.comment = input.comment;
    this.collects = input.collects;
    this.images = new Images().deserialize(input.images);
    return this;
  }
}
