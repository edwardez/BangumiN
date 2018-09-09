import {Serializable} from '../Serializable';
import {SpoilerBase} from './spoiler-base';
import {RuntimeConstantsService} from '../../services/runtime-constants.service';
import {RelatedSubjectsUserInput} from './spoiler-new';

export class SpoilerExisted extends SpoilerBase implements Serializable<SpoilerExisted> {

  relatedSubjects: RelatedSubjectsUserInput[];
  createdAt: Date;
  userId: number | string;

  constructor(spoilerText?: any[], relatedSubjects?: RelatedSubjectsUserInput[], createdAt?: Date, userId?: string | number) {
    super(spoilerText);
    this.relatedSubjects = relatedSubjects || [];
    this.createdAt = createdAt || null;
    this.userId = userId || RuntimeConstantsService.defaultUserId;
  }

  deserialize(input) {
    super.deserialize(input);
    // TODO: deserialize relatedSubjects
    this.relatedSubjects = input.relatedSubjects || [];
    this.createdAt = input.createdAt ? new Date(input.createdAt) : null;
    this.userId = input.userId || RuntimeConstantsService.defaultUserId;
    return this;
  }
}
