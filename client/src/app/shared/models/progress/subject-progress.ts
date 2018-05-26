import {Serializable} from '../Serializable';
import {EpisodeProgress} from './episode-progress';
import {EpisodeType} from '../../enums/episode-type';

export class SubjectProgress implements Serializable<SubjectProgress> {
    /**
     * 条目 ID
     * example: 12
     * format: int32
     */
    id: number;
    episodes: EpisodeProgress[];
    episodesObject: {};
    episodeSortMinMaxByType = {};

    constructor(id = 0) {
        this.id = id;
        this.episodes = [];
        this.episodesObject = {};

        // initialize progressMinMaxByType
        for (const episodeTypeValue in EpisodeType) {
            if (!isNaN(Number(episodeTypeValue))) {
                this.episodeSortMinMaxByType[parseInt(episodeTypeValue, 10)] = {
                    min: Number.MAX_VALUE,
                    max: Number.MIN_VALUE
                };
            }
        }
    }

    deserialize(input) {
        this.id = input.subject_id;
        this.episodes = input.eps === undefined ? [] : input.eps.map(episode => new EpisodeProgress().deserialize(episode));
        this.episodesObject = Object.assign({}, ...this.episodes.map(episode => ({[episode.id]: episode})));

        // initialize progressMinMaxByType
        for (const episodeTypeValue in EpisodeType) {
            if (!isNaN(Number(episodeTypeValue))) {
                this.episodeSortMinMaxByType[parseInt(episodeTypeValue, 10)] = {
                    min: Number.MAX_VALUE,
                    max: Number.MIN_VALUE
                };
            }
        }
        return this;
    }

}
