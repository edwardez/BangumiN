export class BangumiUser implements Serializable<BangumiUser> {
  user_id: number;
  avatar: string;
  nickname: string;
  username: string;

  deserialize(input) {
    this.user_id = input.id;
    this.avatar = input.avatar.large;
    this.nickname = input.nickname;
    this.username = input.username;
    return this;
  }



}
