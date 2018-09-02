import {Serializable} from '../Serializable';
import {SpoilerBase} from './spoiler-base';
import {SubjectBase} from '../subject/subject-base';

export class SpoilerExisted extends SpoilerBase implements Serializable<SpoilerExisted> {

  relatedSubjects: SubjectBase[];

  constructor(spoilerText?: any[], relatedSubjects?: SubjectBase[]) {
    super(spoilerText);
    this.relatedSubjects = relatedSubjects || [];
  }

  deserialize(input) {
    super.deserialize(input);
    this.relatedSubjects = input.relatedSubjects || [];
    return this;
  }
}
