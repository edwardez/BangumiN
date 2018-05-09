import {Serializable} from '../Serializable';
import {SubjectSmall} from './subject-small';
import {Crt} from '../mono/crt';
import {Staff} from '../mono/staff';

export class SubjectMedium extends SubjectSmall implements Serializable<SubjectMedium> {
  /** 角色信息 */
  crt?: Crt[];
  /** 制作人员信息 */
  staff?: Staff[];

  deserialize(input) {
    super.deserialize(input);
    this.crt = input.crt;
    this.staff = input.staff;
    return this;
  }

}
