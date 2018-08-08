import {Serializable} from '../Serializable';


export class BanguminUser implements Serializable<BanguminUser> {
  id: string;
  appLanguage?: string;
  bangumiLanguage?: string;

  constructor() {
    this.id = '0';
    this.appLanguage = 'zh-Hans';
    this.bangumiLanguage = 'original';
  }

  deserialize(input) {
    this.id = input.id || '0';
    this.appLanguage = input.appLanguage || 'zh-Hans';
    this.bangumiLanguage = input.bangumiLanguage || 'original';
    return this;
  }


}


