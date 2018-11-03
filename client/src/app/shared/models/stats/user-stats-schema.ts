import {RecordSchema} from './record-schema';

export interface UserStatsSchema {
  userId?: number;
  lastModified: number;
  stats: RecordSchema[];
}


