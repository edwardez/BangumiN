import {Serializable} from '../Serializable';
import {SubjectSmall} from './subject-small';
import {Character} from '../mono/character';
import {Staff} from '../mono/staff';

export class SubjectMedium extends SubjectSmall implements Serializable<SubjectMedium> {
  /** 角色信息 */
  character?: Character[];
  /** 制作人员信息 */
  staff?: Staff[];

  deserialize(input) {
    super.deserialize(input);
    input.characterArray = Array.isArray(input.crt) ? input.crt : [];
    input.staffArray = Array.isArray(input.staff) ? input.staff : [];

    this.character = input.characterArray.reduce((accumulatedValue, currentValue) => {
      accumulatedValue.push(new Character().deserialize(currentValue));
      return accumulatedValue;
    }, []);

    this.staff = input.staffArray.reduce((accumulatedValue, currentValue) => {
      accumulatedValue.push(new Staff().deserialize(currentValue));
      return accumulatedValue;
    }, []);

    return this;
  }

}
