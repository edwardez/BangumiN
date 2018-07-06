import {Serializable} from '../Serializable';
import {CommonUtils} from '../../utils/common-utils';

export class Alias implements Serializable<Alias> {

  /** 日文名 */
  jp?: string;
  /** 纯假名 */
  kana?: string;
  /** 昵称 */
  nick?: string;
  /** 罗马字 */
  romaji?: string;
  /** 第二中文名 */
  zh?: string;

  constructor() {
    this.jp = null;
    this.kana = null;
    this.nick = null;
    this.romaji = null;
    this.zh = null;
    CommonUtils.copyCustomizedProperties({}, this);
  }

  deserialize(input) {
    if (input) {
      this.jp = input.jp ? input.jp : null;
      this.kana = input.kana ? input.kana : null;
      this.nick = input.nick ? input.nick : null;
      this.romaji = input.romaji ? input.romaji : null;
      this.zh = input.zh ? input.zh : null;
      CommonUtils.copyCustomizedProperties(input, this);
      return this;
    } else {
      return new Alias();
    }

  }
}
