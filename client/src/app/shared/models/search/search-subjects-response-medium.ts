import {Serializable} from '../Serializable';
import {SubjectBase} from '../subject/subject-base';
import {SubjectType} from '../../enums/subject-type.enum';
import {SubjectCollection} from '../subject/subject-collection';


export class SubjectSearchMedium extends SubjectBase implements Serializable<SubjectSearchMedium> {
  /**
   * episodes
   * example: 27
   */
  eps: number;
  /**
   * episodes count(only in search response, no difference with eps?)
   * example: 27
   */
  epsCount: number;
  collection: SubjectCollection;

  deserialize(input) {
    super.deserialize(input);
    this.eps = input.eps || [];
    this.epsCount = input.eps_count || null;
    this.collection = input.collection === undefined ? new SubjectCollection() : new SubjectCollection().deserialize(input.collection);
    return this;
  }
}

export class SearchSubjectsResponseMedium implements Serializable<SearchSubjectsResponseMedium> {

  count: number;

  searchFilterType: SubjectType;

  subjects: SubjectSearchMedium[];

  constructor(count?: number, searchFilterType?: SubjectType, subjects?: SubjectSearchMedium[]) {
    this.count = count || 0;
    this.searchFilterType = searchFilterType || SubjectType.all;
    this.subjects = subjects || [];
  }


  deserialize(input, searchFilterType = SubjectType.all) {
    this.count = input.results || 0;
    this.searchFilterType = searchFilterType || SubjectType.all;
    this.subjects = (input.list || []).map(subject => new SubjectSearchMedium().deserialize(subject));
    return this;
  }
}
