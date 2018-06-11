import {Serializable} from '../Serializable';

export class BangumiRefreshTokenResponse implements Serializable<BangumiRefreshTokenResponse> {

  accessToken: string;
  expiresIn: number;
  tokenType: string;
  scope: string;
  userId: number;
  refreshToken: string;

  deserialize(input): BangumiRefreshTokenResponse {
    this.accessToken = input.access_token;
    this.expiresIn = input.expires_in;
    this.tokenType = input.token_type;
    this.scope = input.scope;
    this.userId = input.user_id;
    this.refreshToken = input.refresh_token;
    return this;
  }
}
