import {Images} from './Images';
import {Serializable} from './Serializable';

export const DEFAULT_SUBJECT_ID = 0;

export class SubjectBaseImpl implements Serializable<SubjectBaseImpl> {
  /**
   * 条目 ID
   * example: 12
   * format: int32
   */
  id?: number;
  /**
   * 条目地址
   * example: http://bgm.tv/subject/12
   */
  url?: string;
  type?: number;
  /**
   * 条目名称
   * example: ちょびっツ
   */
  name?: string;
  /**
   * 条目中文名称
   * example: 人形电脑天使心
   */
  nameCN?: string;

  /**
   * 剧情简介
   */
  summary?: string;
  /**
   * 放送开始日期
   * example: 2002-04-02
   */
  airDate?: Date;
  /**
   * 放送星期
   * example: 2
   * format: int32
   */
  airWeekday?: number;

  images?: Images;

  constructor(id?: number, url?: string, type?: number, name?: string, nameCN?: string, summary?: string,
              airDate?: Date, airWeekday?: number, images?: Images) {
    this.id = id || DEFAULT_SUBJECT_ID;
    this.url = url || '';
    this.type = type || 0;
    this.name = name || '';
    this.nameCN = nameCN || '';
    this.summary = summary || '';
    this.airDate = airDate || null;
    this.airWeekday = airWeekday || null;
    this.images = new Images();
  }

  deserialize(input: any) {
    this.id = input.id || DEFAULT_SUBJECT_ID;
    this.url = input.url === undefined ? '' : input.url.replace(/^http:/, 'https:');
    this.type = input.type || 0;
    this.name = input.name || '';
    this.nameCN = input.nameCn || '';
    this.summary = input.summary || '';
    this.airDate = input.airDate || null;
    this.airWeekday =  input.airWeekday || null;
    this.images = input.images || new Images();
    return this;
  }
}
