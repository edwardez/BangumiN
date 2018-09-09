import {Serializable} from '../Serializable';
import {SpoilerBase} from './spoiler-base';
import {SubjectBase} from '../subject/subject-base';


/**
 * Related subjects info, received while a new spoiler is created
 * Only name and subject id will be taken as only these two info can be trusted
 */
export interface RelatedSubjectsUserInput {
  id: number;
  name: string;
}

export class SpoilerNew extends SpoilerBase implements Serializable<SpoilerNew> {

  relatedSubjects: RelatedSubjectsUserInput[];
  spoilerTextHtml: string;

  constructor(spoilerText?: any[], relatedSubjects?: SubjectBase[]) {
    super(spoilerText);
    this.relatedSubjects = SpoilerNew.normalizeRelatedSubjects(relatedSubjects || []);
  }

  static normalizeRelatedSubjects(relatedSubjects?: SubjectBase[]): RelatedSubjectsUserInput[] {
    return relatedSubjects.map((relatedSubject: SubjectBase) => {
      return {
        id: relatedSubject.id,
        name: relatedSubject.subjectName.preferred
      };
    });
  }

  deserialize(input) {
    super.deserialize(input);
    this.relatedSubjects = SpoilerNew.normalizeRelatedSubjects(input.relatedSubjects || []);
    return this;
  }
}
