import {SubjectLarge} from '../subject/subject-large';


export class ReviewDialogData {

  subject: SubjectLarge;
  enableSpoilerFlag: boolean;

  constructor(subject: SubjectLarge, enableSpoilerFlag = false) {
    this.subject = subject;
    this.enableSpoilerFlag = enableSpoilerFlag;
  }
}
