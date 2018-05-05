import {Serializable} from '../Serializable';
import {CollectionStatus} from './collection-status';
import {BangumiUser} from '../BangumiUser';
import {environment} from '../../../../environments/environment';

export class CollectionResponse  implements Serializable<CollectionResponse> {

  status?: CollectionStatus;
  /**
   * 评分
   * format: int32
   */
  rating?: number;
  /** 评论 */
  comment?: string;
  private?: number;
  /** 标签 */
  tags?: string[];
  /**
   * 完成话数
   * format: int32
   */
  epStatus?: number;
  /**
   * 上次更新时间
   * format: int32
   */
  lastTouch?: number;

  user?: BangumiUser;

  constructor() {
    this.status = new CollectionStatus();
    this.rating = 0;
    this.comment = '';
    this.private = 0;
    this.tags = [''];
    this.epStatus = 0;
    this.lastTouch = 0;
    this.user = new BangumiUser();
  }

  deserialize(input): CollectionResponse {
    this.status = input.status === undefined ? new CollectionStatus() : new CollectionStatus().deserialize(input.status);
    this.rating = input.rating === undefined ? 0 : input.rating;
    // in case comment is  longer than maximum: truncate it
    this.comment = input.comment === undefined ? '' : input.comment.substring(0, environment.commentMaxLength);
    this.private = input.private === undefined ? 0 : input.private;
    this.tags = input.tag === undefined ? [''] : (input.tags === undefined ? [''] : input.tags);
    this.epStatus = input.ep_status === undefined ? 0 : input.ep_status;
    this.lastTouch = input.lasttouch === undefined ? 0 : input.lasttouch;
    this.user = input.user === undefined ? new BangumiUser() : input.user;
    return this;
  }
}
