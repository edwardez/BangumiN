import {Serializable} from '../Serializable';
import {EpisodeStatus} from './episode-status';

export class EpisodeProgress implements Serializable<EpisodeProgress> {
  /**
   * 条目 ID
   * example: 12
   * format: int32
   */
  id: number;
  status: EpisodeStatus;

  deserialize(input) {
    this.id = input.id || 0;
    this.status = new EpisodeStatus().deserialize(input.status);
    return this;
  }

}
