import {Column, DataType, Model, PrimaryKey, Sequelize, Table} from 'sequelize-typescript';
import snakecase_keys from 'snakecase-keys';
import {DataTypes} from 'sequelize';
import dayjs from 'dayjs';

export interface RecordSchema{
  subjectId: number;
  userId: number;
  username: string;
  nickname: string;
  subjectType: number;
  collectionStatus: number;
  addDate: number;
  rate: number;
  tags: string[];
  comment: string;
  rowLastModified: number;
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
    get() {
      const addDate = this.getDataValue('addDate');
      return dayjs(addDate).valueOf();
    },
  })
  addDate: number;

  @Column
  rate: number;

  @Column(DataType.ARRAY(DataType.STRING))
  tags: string[];

  @Column
  comment: string;

  @Column({
    field: 'row_last_modified',
    get() {
      const rowLastModified = this.getDataValue('rowLastModified');
      return dayjs(rowLastModified).valueOf();
    },
  })
  rowLastModified: number;

}
