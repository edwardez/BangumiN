import {RecordSchema} from './record-schema';

export interface SubjectStatsSchema {
  subjectId?: number;
  lastModified: number;
  stats: RecordSchema[];
}
