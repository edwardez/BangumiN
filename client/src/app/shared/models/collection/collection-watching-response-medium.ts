import {Serializable} from '../Serializable';
import {SubjectWatchingCollectionMedium} from '../subject/subject-watching-collection-medium';

export class CollectionWatchingResponseMedium implements Serializable<CollectionWatchingResponseMedium> {
  /** 番剧标题 */
  name?: string;
  /**
   * 章节 ID
   * format: int32
   */
  subject_id?: number;
  /**
   * 完成话数
   * format: int32
   */
  ep_status?: number;
  /** 完成卷数（书籍） */
  vol_status?: number;
  /**
   * 上次更新时间
   * format: int32
   */
  lastTouch?: number;
  subject?: SubjectWatchingCollectionMedium;


  deserialize(input) {
    this.name = input.name || '';
    this.subject_id = input.subject_id || 0;
    this.ep_status = input.ep_status || 0;
    this.vol_status = input.vol_status || 0;
    this.lastTouch = input.lasttouch || 0;
    this.subject = input.subject === undefined ?
      new SubjectWatchingCollectionMedium() : new SubjectWatchingCollectionMedium().deserialize(input.subject);
    return this;
  }
}
