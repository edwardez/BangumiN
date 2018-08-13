import {Serializable} from '../Serializable';
import {Mono} from './mono';
import {MonoBase} from './mono-base';
import {MonoInfo} from './mono-info';

export class Character extends Mono implements Serializable<Character> {
  /**
   * 角色类型
   * example: 主角
   */
  roleName?: string;
  info?: MonoInfo;
  actors?: MonoBase[];

  deserialize(input) {
    super.deserialize(input);
    this.roleName = input.role_name ? input.role_name : '';
    this.info = new MonoInfo().deserialize(input.info ? input.info : {});

    input.actorsArray = Array.isArray(input.actors) ? input.actors : [];
    this.actors = input.actorsArray.reduce((accumulatedValue, currentValue) => {
      accumulatedValue.push(new MonoBase().deserialize(currentValue));
      return accumulatedValue;
    }, []);

    return this;
  }
}
