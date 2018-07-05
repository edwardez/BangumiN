import {Serializable} from '../Serializable';
import {Images} from '../common/images';

export class MonoBase implements Serializable<MonoBase> {

  /**
   * 人物 ID
   * format: int32
   */
  id: number;
  /** 人物地址 */
  url?: string;
  /** 姓名 */
  name?: string;
  images?: Images;

  deserialize(input) {
    this.id = input.id ? input.id : 0;
    this.url = input.url ? input.url.replace(/^http:/, 'https:') : '';
    this.name = input.name ? input.name : '';
    this.images = new Images().deserialize(input.images);
    return this;
  }
}
