import {Serializable} from '../Serializable';
import {SpoilerBase} from './spoiler-base';
import {RuntimeConstantsService} from '../../services/runtime-constants.service';
import {RelatedSubjectsUserInput} from './spoiler-new';
import {SubjectBase} from '../subject/subject-base';

export class SpoilerExisted extends SpoilerBase implements Serializable<SpoilerExisted> {

  relatedSubjects: RelatedSubjectsUserInput[];
  relatedSubjectsBaseDetails: SubjectBase[];
  createdAt: Date;
  userId: number | string;
  spoilerId: string;

  constructor(spoilerText?: any[], relatedSubjects?: RelatedSubjectsUserInput[], createdAt?: Date, userId?: string | number,
              spoilerId?: string) {
    super(spoilerText);
    this.relatedSubjects = relatedSubjects || [];
    this.createdAt = createdAt || null;
    this.userId = userId || RuntimeConstantsService.defaultUserId;
    this.spoilerId = spoilerId || RuntimeConstantsService.defaultSpoilerId;
  }

  updateRelatedSubjectsDetails(relatedSubjectsBaseDetails: SubjectBase[]) {
    if (!relatedSubjectsBaseDetails || relatedSubjectsBaseDetails.length <= 0) {
      this.relatedSubjectsBaseDetails = null;
    } else {
      this.relatedSubjectsBaseDetails = relatedSubjectsBaseDetails;
    }
  }

  deserialize(input) {
    super.deserialize(input);
    // TODO: deserialize relatedSubjects
    this.relatedSubjects = input.relatedSubjects || [];
    this.createdAt = input.createdAt ? new Date(input.createdAt) : null;
    this.userId = input.userId || RuntimeConstantsService.defaultUserId;
    this.spoilerId = input.spoilerId || RuntimeConstantsService.defaultSpoilerId;
    return this;
  }
}
