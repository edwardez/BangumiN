import {Serializable} from '../Serializable';
import {EpisodeType} from '../../enums/episode-type';
import {EpisodeOnAirStatus} from '../../enums/episode-on-air-status';
import {EpisodeCollectionStatus} from '../../enums/episode-collection-status';

export class Episode implements Serializable<Episode> {
  /**
   * 章节 ID
   * example: 1027
   * format: int32
   */
  id?: number;
  /**
   * 章节地址
   * example: http://bgm.tv/ep/1027
   */
  url?: string;
  type?: EpisodeType;
  /**
   * 集数
   * example: 1
   * format: int32
   */
  sort?: number;
  /**
   * 标题
   * example: ちぃ 目覚める
   */
  name?: string;
  /**
   * 简体中文标题
   * example: 叽，觉醒了
   */
  nameCN?: string;
  /**
   * 时长
   * example: 24m
   */
  duration?: string;
  /**
   * 放送日期
   * example: 2002-04-03
   */
  airDate?: string;
  /**
   * 回复数量
   * example: 9
   * format: int32
   */
  comment?: number;
  /** 简介 */
  desc?: string;

  /**
   * status of episode
   */
  status?: EpisodeOnAirStatus;

  userCollectionStatus?: EpisodeCollectionStatus;

  deserialize(input) {
    this.id = input.id || 0;
    this.url = input.url === undefined ? '' : input.url.replace(/^http:/, 'https:');
    this.type = input.type || 0;
    this.sort = input.sort || 0;
    this.name = input.name || '';
    this.nameCN = input.name_cn || '';
    this.duration = input.duration || '';
    this.airDate = input.airdate || '';
    this.comment = input.comment || 0;
    this.desc = input.desc || '';
    this.status = input.status || EpisodeOnAirStatus.Air;
    this.userCollectionStatus = EpisodeCollectionStatus.untouched; // default to untouched
    return this;
  }

}
