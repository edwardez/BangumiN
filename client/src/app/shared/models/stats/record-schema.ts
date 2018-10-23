import {CollectionStatusId} from '../../enums/collection-status-id';
import {SubjectType} from '../../enums/subject-type.enum';

export interface RecordSchema {
  subjectId?: number;
  userId?: number;
  username?: string;
  nickname?: string;
  subjectType?: SubjectType;
  collectionStatus?: CollectionStatusId;
  addDate?: string;
  rate?: number;
  tags?: string[];
  comment?: string;
}
