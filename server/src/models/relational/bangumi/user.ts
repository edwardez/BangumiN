import {Column, DataType, Model, PrimaryKey, Table} from 'sequelize-typescript';
import snakecase_keys from 'snakecase-keys';

import {Avatar} from './common/Avatar';

export interface BangumiUserSchema{
  id: number;
  url: string;
  sign: string;
  avatar: Avatar;
  nickname: string;
  username: string;
}

@Table({
  tableName: 'user',
})
export class User extends Model<User> implements BangumiUserSchema{

  @PrimaryKey
  @Column
  id: number;

  @Column
  username: string;

  @Column
  nickname: string;

  @Column
  url: string;

  @Column(DataType.JSONB)
  avatar: Avatar;

  @Column
  sign: string;

  @Column({
    field: 'user_group',
  })
  @Column
  userGroup: number;

  // To be in consistent with Bangumi's API response, we'll convert it back to underscore when toJSON() is called
  toJSON() {
    return snakecase_keys(super.toJSON());
  }

}
