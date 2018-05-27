import {Serializable} from '../Serializable';
import {Alias} from './alias';

/** 人物信息 */
export class MonoInfo implements Serializable<MonoInfo> {
  /**
   * 生日
   * example: 4月13日
   */
  birth?: string;
  /**
   * 身高
   * example: 152cm
   */
  height?: string;
  /**
   * 性别
   * example: 女
   */
  gender?: string;
  alias?: Alias;
  /** 引用来源 */
  source?: object;
  /** 简体中文名 */
  name_cn?: string;
  /** 声优 */
  cv?: string;

  deserialize(input): MonoInfo {
    this.birth = input.birth;
    this.height = input.height;
    this.gender = input.gender;
    this.name_cn = input.name_cn;
    this.cv = input.cv;
    this.alias = new Alias().deserialize(input.alias);
    return this;
  }
}
