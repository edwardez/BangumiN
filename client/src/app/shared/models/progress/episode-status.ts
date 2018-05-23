import {Serializable} from '../Serializable';

export class EpisodeStatus implements Serializable<EpisodeStatus> {
  /**
   * status ID
   * example: 12
   * format: int32
   */
  id: EpisodeCollectionStatus;
  cssName: string;
  urlName: string;
  cnName: string;

  deserialize(input) {
    this.id = input.id === undefined ? 1 : input.id;
    this.cssName = input.css_name || '';
    this.urlName = input.url_name || '';
    this.cnName = input.cn_name || '';
    return this;
  }

}
