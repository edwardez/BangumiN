import {SubjectBase} from './subject-base';
import {Serializable} from '../Serializable';
import {Images} from '../common/images';
import {Episode} from '../episode/episode';

export class SubjectEpisodes extends SubjectBase implements Serializable<SubjectEpisodes> {
  /**
   * array of episodes
   * format: array
   */
  episodes?: Episode[];
  /**
   * used for lookup episode info(episode id is the hash key)
   * since hash is faster than object array if search is frequently needed
   */
  episodesObject?: {};

  images?: Images;

  constructor() {
    super();
    this.episodes = [];
    this.images = new Images();
  }

  deserialize(input) {
    super.deserialize(input);
    this.images = input.images === undefined ? new Images() : new Images().deserialize(input.images);
    this.episodes = input.eps === undefined ? [] : input.eps.map(ep => new Episode().deserialize(ep));
    this.episodesObject = Object.assign({}, ...this.episodes.map(episode => ({ [episode.id]: episode }) ) );
    return this;
  }

}
