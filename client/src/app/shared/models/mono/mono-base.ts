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

    const defaultMonoImage = 'https://bgm.tv//img/info_only_m.png';

    this.id = input.id ? input.id : 0;
    this.url = input.url ? input.url.replace(/^http:/, 'https:') : null;
    this.name = input.name ? input.name : '';
    this.images = new Images(defaultMonoImage).deserialize(input.images, defaultMonoImage);
    return this;
  }
}
