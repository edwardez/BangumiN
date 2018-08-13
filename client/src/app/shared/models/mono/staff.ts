import {Serializable} from '../Serializable';
import {Mono} from './mono';
import {MonoInfo} from './mono-info';

export class Staff extends Mono implements Serializable<Staff> {
  /**
   * 人物类型
   * example: 主角
   */
  roleName?: string;
  // placeholder to avoid collision, not in use
  role_name = null;
  /** 职位 */
  jobs?: string[];
  info?: MonoInfo;

  deserialize(input) {
    super.deserialize(input);
    this.roleName = input.role_name ? input.role_name : '';
    this.jobs = Array.isArray(input.jobs) ? input.jobs : [];
    this.info = new MonoInfo().deserialize(input.info ? input.info : {});
    return this;
  }
}
