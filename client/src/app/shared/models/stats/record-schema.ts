import {CollectionStatusId} from '../../enums/collection-status-id';
import {SubjectType} from '../../enums/subject-type.enum';

export interface RecordSchema {
  subjectId?: number;
  userId?: number;
  username?: string;
  nickname?: string;
  subjectType?: SubjectType;
  collectionStatus: CollectionStatusId;
  addDate: number;
  addedAt: Date;
  rate: number;
  tags?: string[];
  comment?: string;
}


export class Records {

  /**
   * Convert epoch time into javascript date object
   * @param statsData All raw records
   */
  static buildAddedAt(statsData: RecordSchema[]): RecordSchema[] {
    if (!statsData) {
      return [];
    }
    statsData.forEach(record => {
      record.addedAt = new Date(record.addDate);
    });
    return statsData;
  }
}
