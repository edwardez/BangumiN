import {Serializable} from '../Serializable';

export class SubjectBase implements Serializable<SubjectBase> {
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
  name_cn?: string;
  /**
   * 剧情简介
   */
  summary?: string;
  /**
   * 放送开始日期
   * example: 2002-04-02
   */
  air_date?: string;
  /**
   * 放送星期
   * example: 2
   * format: int32
   */
  air_weekday?: number;

  deserialize(input) {
    this.id = input.id;
    this.url = input.url.replace(/^http:/, 'https:');
    this.type = input.type;
    this.name = input.name;
    this.name_cn = input.name_cn;
    this.summary = input.summary;
    this.air_date = input.air_date;
    this.air_weekday = input.air_weekday;
    return this;
  }

}
