import {Column, DataType, Model, PrimaryKey, Sequelize, Table} from 'sequelize-typescript';
import snakecase_keys from 'snakecase-keys';
import {DataTypes} from 'sequelize';

export interface RecordSchema{
  subjectId: number;
  userId: number;
  username: string;
  nickname: string;
  subjectType: number;
  collectionStatus: number;
  addDate: Date;
  rate: number;
  tags: string[];
  comment: string;
  rowLastModified: Date;
}

@Table({
  tableName: 'record',
})
export class Record extends Model<Record> implements RecordSchema{

  @PrimaryKey
  @Column({
    field: 'subject_id',
  })
  subjectId: number;

  @PrimaryKey
  @Column({
    field: 'user_id',
  })
  userId: number;

  @Column
  username: string;

  @Column
  nickname: string;

  @Column({
    field: 'subject_type',
  })
  subjectType: number;

  @Column({
    field: 'collection_status',
  })
  collectionStatus: number;

  @Column({
    field: 'add_date',
  })
  addDate: Date;

  @Column
  rate: number;

  @Column(DataType.ARRAY(DataType.STRING))
  tags: string[];

  @Column
  comment: string;

  @Column({
    field: 'row_last_modified',
  })
  rowLastModified: Date;

}
