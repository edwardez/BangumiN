import {Serializable} from '../Serializable';
import {SubjectProgress} from './subject-progress';

export class UserProgress implements Serializable<UserProgress> {

  progress: SubjectProgress[];
  progressObject =  {};

  constructor() {
    this.progress = [];
    this.progressObject = {};
  }

  deserialize(input) {
    this.progress = input === undefined || input === null ?
      [] : input.map(subjectProgress => new SubjectProgress().deserialize(subjectProgress));
    this.progressObject = Object.assign({}, ...this.progress.map(subject => ({ [subject.id]: subject }) ) );
    return this;
  }

}
