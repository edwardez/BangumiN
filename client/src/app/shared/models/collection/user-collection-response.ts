import {Serializable} from '../Serializable';
import {BangumiUser} from '../BangumiUser';
import {CollectionStatus} from './collection-status';
import {environment} from '../../../../environments/environment';
import {CollectionResponse} from './collection-response';
import {SubjectType} from '../../enums/subject-type.enum';
import {UserCollection} from './user-collection';

export class UserCollectionResponse implements Serializable<UserCollectionResponse> {

  type?: SubjectType;
  name?: string;
  /**
   * 条目类型中文名
   * example: 动画
   */
  name_cn?: string;
  /** 收藏列表 */
  collectionArray?: UserCollection[];

  constructor(type?: SubjectType) {
    this.type = type || SubjectType.all;
    this.name = SubjectType[type];
    this.name_cn = SubjectType[type];
    this.collectionArray = [];
  }

  deserialize(input): CollectionResponse {
    if (input instanceof Array && input.length >= 1) {
      this.type = input[0].type || SubjectType.all;
      this.name = input[0].name || '';
      this.name_cn = input[0].name_cn || '';
      this.collectionArray = input[0].collects === undefined ?
        [] : input[0].collects.map(collection => new UserCollection().deserialize(collection));
      return this;
    } else {
      this.constructor();
      return this;
    }
  }
}
