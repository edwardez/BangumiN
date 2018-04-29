import {Serializable} from '../Serializable';
import {Mono} from './mono';

export class Crt extends Mono implements Serializable<Crt> {
  /**
   * 角色类型
   * example: 主角
   */
  role_name?: string;

  deserialize(input) {
    super.deserialize(input);
    this.role_name = input.role_name;
    return this;
  }
}
