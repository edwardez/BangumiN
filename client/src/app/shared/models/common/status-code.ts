import {Serializable} from '../Serializable';

export class StatusCode implements Serializable<StatusCode> {
  /** 当前请求的地址 */
  request?: string;
  code?: number;
  /** 状态信息 */
  error?: string;

  deserialize(input) {
    this.request = input.request || '';
    this.code = input.code || 0;
    this.error = input.error || 'Unknown error';
    return this;
  }
}
