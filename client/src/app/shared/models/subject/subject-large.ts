import {SubjectMedium} from './subject-medium';
import {Serializable} from '../Serializable';

export class SubjectLarge extends SubjectMedium implements Serializable<SubjectLarge> {

  /** 章节列表 */
  eps?;
  /** 讨论版 */
  topic?;
  /** 评论日志 */
  blog?;

  deserialize(input) {
    super.deserialize(input);
    this.eps = input.episodes;
    this.topic = input.episodes;
    this.blog = input.blog;
    return this;
  }
}
