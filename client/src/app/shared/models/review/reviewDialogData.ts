import {CollectionStatusType} from '../../enums/collection-status-type';
import {SubjectType} from '../../enums/subject-type.enum';


export class ReviewDialogData {

  subjectId: number;

  // rating of the subject, by current user
  rating: number;

  // tag of the subject, by current user
  tags: string[];

  // type of the status for the subject
  statusType: CollectionStatusType;

  // user comment
  comment: string;

  // is the review in private mode or not
  privacy: number;

  // type of the subject
  type: SubjectType;


  constructor(subjectId: number, rating: number, tags: string[],
              statusType: CollectionStatusType, comment: string, privacy: number, type: SubjectType) {
    this.subjectId = subjectId;
    this.rating = rating;
    this.tags = tags;
    this.statusType = statusType;
    this.comment = comment;
    this.privacy = privacy;
    this.type = type;
  }
}
