import {Serializable} from '../Serializable';
import {Alias} from './alias';
import {CommonUtils} from '../../utils/common-utils';

/** info of a person
 * there might exist user-defined attribute */
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
  nameCN?: string;
  /** 声优 */
  cv?: string;

  // placeholder to avoid collision, not in use
  name_cn = null;

  deserialize(input): MonoInfo {
    this.birth = input.birth ? input.birth : null;
    this.height = input.height ? input.height : null;
    this.gender = input.gender ? input.gender : null;
    this.nameCN = input.name_cn ? input.name_cn : null;
    this.cv = input.cv ? input.cv : null;
    this.alias = new Alias().deserialize(input.alias ? input.alias : {});
    CommonUtils.copyCustomizedProperties(input, this);
    return this;
  }
}
