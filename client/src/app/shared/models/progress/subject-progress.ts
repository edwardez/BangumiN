import {Serializable} from '../Serializable';
import {EpisodeProgress} from './episode-progress';

export class SubjectProgress implements Serializable<SubjectProgress> {
  /**
   * 条目 ID
   * example: 12
   * format: int32
   */
  id: number;
  episodes: EpisodeProgress[];
  episodesObject: {};

  deserialize(input) {
    this.id = input.subject_id;
    this.episodes = input.eps === undefined ? [] : input.eps.map(episode => new EpisodeProgress().deserialize(episode));
    this.episodesObject = Object.assign({}, ...this.episodes.map(episode => ({ [episode.id]: episode }) ) );
    return this;
  }

}
