import {Serializable} from '../Serializable';
import {SubjectProgress} from './subject-progress';
import {EpisodeType} from '../../enums/episode-type';

export class UserProgress implements Serializable<UserProgress> {

    progress: SubjectProgress[];

    constructor() {
        this.progress = [];
    }

    deserialize(input) {
        this.progress = input === undefined || input === null ?
            [] : input.map(subjectProgress => new SubjectProgress().deserialize(subjectProgress));
        return this;
    }

}
