import {Serializable} from './Serializable';

export class Avatar implements Serializable<Avatar> {

  /** example: https://lain.bgm.tv/pic/user/l/icon.jpg */
  large?: string;
  /** example: https://lain.bgm.tv/pic/user/m/icon.jpg */
  medium?: string;
  /** example: https://lain.bgm.tv/pic/user/s/icon.jpg */
  small?: string;

  constructor(large?: string, medium?: string, small?: string) {
    this.large = this.large || 'https://lain.bgm.tv/pic/user/l/icon.jpg';
    this.medium = this.medium || 'https://lain.bgm.tv/pic/user/m/icon.jpg';
    this.small = this.small || 'https://lain.bgm.tv/pic/user/s/icon.jpg';
  }

  deserialize(input: any) {
    this.large = input.large || '';
    this.medium = input.medium || '';
    this.small = input.small || '';
    return this;
  }

}
