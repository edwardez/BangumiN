import {Column, Model, PrimaryKey, Table} from 'sequelize-typescript';
import config from '../../../config/components/common';

export interface UserExcludeSchema {
  userId: number;
  reason: string;
}

@Table({
  tableName: `user_exclude_${config.env}`,
})
export class UserExclude extends Model<UserExclude> implements UserExcludeSchema {

  @PrimaryKey
  @Column({
    field: 'user_id',
  })
  userId: number;

  @Column
  reason: string;
}
