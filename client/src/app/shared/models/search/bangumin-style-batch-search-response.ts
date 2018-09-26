import {BangumiUser} from '../BangumiUser';
import {Serializable} from '../Serializable';

export class BanguminStyleUserBatchSearchResponse implements Serializable<BanguminStyleUserBatchSearchResponse> {
  count: number;
  rows: BangumiUser[];

  deserialize(input): BanguminStyleUserBatchSearchResponse {
    this.count = input.count || 0;
    this.rows = (input.rows || []).map(bangumiUser => new BangumiUser().deserialize(bangumiUser));
    return this;
  }
}
