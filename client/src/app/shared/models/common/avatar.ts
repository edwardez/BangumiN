import {Serializable} from '../Serializable';

export class Avatar implements Serializable<Avatar> {

  /** example: https://lain.bgm.tv/pic/user/l/icon.jpg */
  large?: string;
  /** example: https://lain.bgm.tv/pic/user/m/icon.jpg */
  medium?: string;
  /** example: https://lain.bgm.tv/pic/user/s/icon.jpg */
  small?: string;

  // in case avatar url is undefined, get fallback avatar url (if available), otherwise get the default
  private static getFallbackAvatarUrl(avatarUrlObject) {
    for (const url of Object.values(avatarUrlObject)) {
      if (url) {
        return url.replace(/^http:/, 'https:');
      }
    }

    return 'https://lain.bgm.tv/pic/user/s/icon.jpg';
  }

  constructor() {
    this.large = 'https://lain.bgm.tv/pic/user/l/icon.jpg';
    this.medium = 'https://lain.bgm.tv/pic/user/m/icon.jpg';
    this.small = 'https://lain.bgm.tv/pic/user/s/icon.jpg';
  }

  deserialize(input) {
    this.large = input.large === undefined ? Avatar.getFallbackAvatarUrl(input) : input.large.replace(/^http:/, 'https:');
    this.medium = input.medium === undefined ? Avatar.getFallbackAvatarUrl(input) : input.medium.replace(/^http:/, 'https:');
    this.small = input.small === undefined ? Avatar.getFallbackAvatarUrl(input) : input.small.replace(/^http:/, 'https:');
    return this;
  }

}
