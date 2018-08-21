import {Serializable} from '../Serializable';
import {SubjectBase} from '../subject/subject-base';
import {SubjectType} from '../../enums/subject-type.enum';

export class SearchSubjectsResponseSmall implements Serializable<SearchSubjectsResponseSmall> {

  count: number;

  searchFilterType: SubjectType;

  subjects: SubjectBase[];

  constructor(count?: number, searchFilterType?: SubjectType, subjects?: SubjectBase[]) {
    this.count = count || 0;
    this.searchFilterType = searchFilterType || SubjectType.all;
    this.subjects = subjects || [];
  }


  deserialize(input, searchFilterType = SubjectType.all) {
    this.count = input.results || 0;
    this.searchFilterType = searchFilterType || SubjectType.all;
    this.subjects = (input.list || []).map(subject => new SubjectBase().deserialize(subject));
    return this;
  }
}
