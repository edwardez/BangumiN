import {Column, DataType, Model, PrimaryKey, Table} from 'sequelize-typescript';
import {Images} from './common/images';
import {SubjectCollection} from './common/SubjectCollection';


import * as Bluebird from 'bluebird';
import {SubjectRating} from './common/SubjectRating';

declare global {
  export interface Promise<T> extends Bluebird<T> {
  }
}

@Table({
  tableName: 'subject',
})
export class Subject extends Model<Subject> {

  @PrimaryKey
  @Column
  id: number;

  @Column
  url: string;

  @Column
  type: number;

  @Column
  name: string;

  @Column({
    field: 'name_cn',
  })
  nameCN: string;

  @Column(DataType.TEXT)
  summary: string;

  @Column({
    field: 'air_date',
  })
  @Column
  airDate: Date;

  @Column({
    field: 'air_weekday',
  })
  @Column
  airWeekday: number;

  @Column(DataType.JSONB)
  rating: SubjectRating;

  @Column(DataType.JSONB)
  images: Images;

  @Column(DataType.JSONB)
  collection: SubjectCollection;

  @Column
  rank: number;

  @Column
  eps: number;

  @Column({
    field: 'eps_count',
  })
  @Column
  epsCount: number;

  @Column({
    field: 'true_id',
  })
  @Column
  trueId: number;

}
