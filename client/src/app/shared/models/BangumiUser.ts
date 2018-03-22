interface AvatarType {
  large: string;
  medium: string;
  small: string;
}

export class BangumiUser implements Serializable<BangumiUser> {

  user_id: number;
  avatar: AvatarType;
  nickname: string;
  username: string;

  deserialize(input) {
    this.user_id = input.id;
    this.avatar = {
      'large': input.avatar.large.replace(/^http:/, 'https:'), // convert http link to https
      'medium': input.avatar.medium.replace(/^http:/, 'https:'), // convert http link to https
      'small': input.avatar.small.replace(/^http:/, 'https:'), // convert http link to https
    };
    this.nickname = input.nickname;
    this.username = input.username;
    return this;
  }



}


