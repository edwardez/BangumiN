import {Serializable} from '../Serializable';
import {EpisodeCollectionStatus} from '../../enums/episode-collection-status';

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

  static setEpisodeStatusID(id: EpisodeCollectionStatus): EpisodeCollectionStatus {
    if (id === undefined || null) {
      return 1;
    } else if (id in EpisodeCollectionStatus) {
      return id;
    } else {
      return EpisodeCollectionStatus.untouched;
    }
  }


  deserialize(input) {
    this.id = EpisodeStatus.setEpisodeStatusID(input.id);
    this.cssName = input.css_name || '';
    this.urlName = input.url_name || '';
    this.cnName = input.cn_name || '';
    return this;
  }


}
