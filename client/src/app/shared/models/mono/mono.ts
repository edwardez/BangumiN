import {Serializable} from '../Serializable';
import {MonoBase} from './mono-base';

export class Mono extends MonoBase implements Serializable<Mono> {

  // placeholder to avoid collision, not in use
  name_cn = null;

  nameCN?: string;
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
    super.deserialize(input);
    this.nameCN = input.name_cn ? input.name_cn : '';
    this.comment = input.comment ? input.comment : 0;
    this.collects = input.collects ? input.collects : 0;
    return this;
  }
}
