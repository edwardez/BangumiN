import {Serializable} from '../Serializable';

export class Images implements Serializable<Images> {

  /** example: http://lain.bgm.tv/pic/cover/l/c2/0a/12_24O6L.jpg */
  large?: string;
  /** example: http://lain.bgm.tv/pic/cover/c/c2/0a/12_24O6L.jpg */
  common?: string;
  /** example: http://lain.bgm.tv/pic/cover/m/c2/0a/12_24O6L.jpg */
  medium?: string;
  /** example: http://lain.bgm.tv/pic/cover/s/c2/0a/12_24O6L.jpg */
  small?: string;
  /** example: http://lain.bgm.tv/pic/cover/g/c2/0a/12_24O6L.jpg */
  grid?: string;

  constructor(defaultImage = 'https://bgm.tv/img/no_icon_subject.png') {
    this.large = defaultImage;
    this.common = defaultImage;
    this.medium = defaultImage;
    this.small = defaultImage;
    this.grid = defaultImage;
  }

  // in case image url is undefined, get fallback image url (if available), otherwise get the default
  private static getFallbackImageUrl(imageUrlObject, defaultImage = 'https://bgm.tv/img/no_icon_subject.png') {
    for (const url of Object.values(imageUrlObject)) {
      if (url) {
        return url.toString().replace(/^http:/, 'https:');
      }
    }

    return defaultImage;
  }

  deserialize(input, defaultImage = 'https://bgm.tv/img/no_icon_subject.png') {
    if (input) {
      this.large = input.large === undefined ? Images.getFallbackImageUrl(input, defaultImage) : input.large.replace(/^http:/, 'https:');
      this.common = input.common === undefined ? Images.getFallbackImageUrl(input, defaultImage) : input.common.replace(/^http:/, 'https:');
      this.medium = input.medium === undefined ? Images.getFallbackImageUrl(input, defaultImage) : input.medium.replace(/^http:/, 'https:');
      this.small = input.small === undefined ? Images.getFallbackImageUrl(input, defaultImage) : input.small.replace(/^http:/, 'https:');
      this.grid = input.grid === undefined ? Images.getFallbackImageUrl(input, defaultImage) : input.grid.replace(/^http:/, 'https:');
      return this;
    } else {
      return new Images(defaultImage);
    }

  }

}
