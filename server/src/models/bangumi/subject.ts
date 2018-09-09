import {Column, DataType, Model, PrimaryKey, Sequelize, Table} from 'sequelize-typescript';
import {Images} from './common/Images';
import {SubjectCollection} from './common/SubjectCollection';
import {SubjectRating} from './common/SubjectRating';
import {SubjectBase} from './common/SubjectBase';
import snakecase_keys from 'snakecase-keys';

export class DefaultSubjectBase implements SubjectBase {
  /**
   * 条目 ID
   * example: 12
   * format: int32
   */
  id?: number;
  /**
   * 条目地址
   * example: http://bgm.tv/subject/12
   */
  url?: string;
  type?: number;
  /**
   * 条目名称
   * example: ちょびっツ
   */
  name?: string;
  /**
   * 条目中文名称
   * example: 人形电脑天使心
   */
  nameCn?: string;

  /**
   * 剧情简介
   */
  summary?: string;
  /**
   * 放送开始日期
   * example: 2002-04-02
   */
  airDate?: Date;
  /**
   * 放送星期
   * example: 2
   * format: int32
   */
  airWeekday?: number;

  images?: Images;

}

@Table({
  tableName: 'subject',
})
export class Subject extends Model<Subject> implements SubjectBase{

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
  nameCn: string;

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

  // To be in consistent with Bangumi's API response, we'll convert it back to underscore when toJSON() is called
  toJSON() {
    return snakecase_keys(super.toJSON());
  }

}
