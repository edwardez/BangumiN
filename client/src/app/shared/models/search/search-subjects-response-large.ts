import {Serializable} from '../Serializable';
import {SubjectType} from '../../enums/subject-type.enum';
import {SubjectSearchMedium} from './search-subjects-response-medium';
import {SubjectRating} from '../subject/subject-rating';

export class SubjectSearchLarge extends SubjectSearchMedium implements Serializable<SubjectSearchMedium> {
  rating: SubjectRating;

  /**
   * ranking
   * example: 573
   */
  rank?: number;

  deserialize(input) {
    super.deserialize(input);
    this.rating = input.rating === undefined ? new SubjectRating() : new SubjectRating().deserialize(input.rating);
    this.rank = input.rank === undefined ? '-' : input.rank;
    return this;
  }
}

export class SearchSubjectsResponseLarge implements Serializable<SearchSubjectsResponseLarge> {

  count: number;

  searchFilterType: SubjectType;

  subjects: SubjectSearchLarge[];

  constructor(count?: number, searchFilterType?: SubjectType, subjects?: SubjectSearchLarge[]) {
    this.count = count || 0;
    this.searchFilterType = searchFilterType || SubjectType.all;
    this.subjects = subjects || [];
  }


  deserialize(input, searchFilterType = SubjectType.all) {
    this.count = input.results || 0;
    this.searchFilterType = searchFilterType || SubjectType.all;
    this.subjects = (input.list || []).map(subject => new SubjectSearchLarge().deserialize(subject));
    return this;
  }

}
