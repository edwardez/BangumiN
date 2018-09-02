import {Serializable} from '../Serializable';
import {SpoilerBase} from './spoiler-base';
import {SubjectBase} from '../subject/subject-base';

export class SpoilerNew extends SpoilerBase implements Serializable<SpoilerNew> {

  relatedSubjects: number[];
  spoilerTextHtml: string;

  constructor(spoilerText?: any[], relatedSubjects?: SubjectBase[]) {
    super(spoilerText);
    this.relatedSubjects = SpoilerNew.normalizeRelatedSubjects(relatedSubjects || []);
  }

  static normalizeRelatedSubjects(relatedSubjects?: SubjectBase[]): number[] {
    return relatedSubjects.map((relatedSubject: SubjectBase) => {
      return relatedSubject.id;
    });
  }

  deserialize(input) {
    super.deserialize(input);
    this.relatedSubjects = SpoilerNew.normalizeRelatedSubjects(input.relatedSubjects || []);
    return this;
  }
}
