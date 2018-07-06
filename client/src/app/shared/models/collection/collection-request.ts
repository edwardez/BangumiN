import {CollectionStatusType} from '../../enums/collection-status-type';

export class CollectionRequest {
  status: CollectionStatusType;
  comment?: string;
  tags?: string[];
  rating?: number;
  privacy?: number;

  constructor(status: CollectionStatusType, comment?, tags?, rating?, privacy?) {
    this.status = status;
    this.comment = comment;
    this.tags = tags;
    this.rating = rating;
    this.privacy = privacy;
  }


}
