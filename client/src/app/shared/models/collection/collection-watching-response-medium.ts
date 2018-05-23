import {Serializable} from '../Serializable';
import {SubjectWatchingCollectionMedium} from '../subject/subject-watching-collection-medium';
import * as PriorityQueue from 'js-priority-queue';
import {Episode} from '../episode/episode';

export class CollectionWatchingResponseMedium implements Serializable<CollectionWatchingResponseMedium> {
  /** 番剧标题 */
  name?: string;
  /**
   * 章节 ID
   * format: int32
   */
  id?: number;
  /**
   * 完成话数
   * format: int32
   */
  completedEpisodeCount?: number;
  /** 完成卷数（书籍） */
  completedVolumeCount?: number;
  /**
   * 上次更新时间
   * format: int32
   */
  lastTouch?: number;
  subject?: SubjectWatchingCollectionMedium;
  episodeHeap?: PriorityQueue<Episode>;


  deserialize(input) {
    this.name = input.name || '';
    this.id = input.subject_id || 0;
    this.completedEpisodeCount = input.ep_status || 0;
    this.completedVolumeCount = input.vol_status || 0;
    this.lastTouch = input.lasttouch || 0;
    this.subject = input.subject === undefined ?
      new SubjectWatchingCollectionMedium() : new SubjectWatchingCollectionMedium().deserialize(input.subject);
    this.episodeHeap = null; // by default, subject doesn't have episode
    return this;
  }
}
