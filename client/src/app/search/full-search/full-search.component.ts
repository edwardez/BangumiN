import {Component, OnInit} from '@angular/core';
import {BangumiSearchService} from '../../shared/services/bangumi/bangumi-search.service';
import {ActivatedRoute} from '@angular/router';
import {concatAll, filter, map, mergeMap, switchMap, takeUntil} from 'rxjs/operators';
import {Observable, from, forkJoin, of} from 'rxjs';
import {SubjectType} from '../../shared/enums/subject-type.enum';
import {_} from '../../shared/utils/translation-marker';

@Component({
  selector: 'app-full-search',
  templateUrl: './full-search.component.html',
  styleUrls: ['./full-search.component.scss']
})
export class FullSearchComponent implements OnInit {

  subjectSearchResult = [];

  constructor(private bangumiSearchService: BangumiSearchService,
              private route: ActivatedRoute) {
  }

  ngOnInit() {
    this.getSearchResult();
  }

  /**
   * this function will get a single type search result if type param presents
   * or forkJoin() multiple results if type is not presented (search all type)
   * forkJoin will block following requests if the current request is delayed
   * the best way is to use mergeMap
   * however, it'll be strange if result is non-blocking(image there're 5 categories, all of them are empty at first,
   * then suddenly game category shows some results, then music category...)
   * every time the sequence will be random, which is not a good UX
   */
  getSearchResult() {
    this.route
      .queryParams
      .pipe(
        filter(params => params['keywords'] !== undefined),
        switchMap(params => {
          const {keywords, type, responseGroup, start, max_results, ...rest} = params;

          // get all number value in enum SubjectType
          const allSubjectType = Object.keys(SubjectType)
            .map(k => SubjectType[k])
            .filter(v => typeof v === 'number') as number[];

          // if type is in parameter list, which means we should only search a single type
          if (type) {
            return forkJoin(this.bangumiSearchService.searchSubject(keywords, type, responseGroup, start, max_results));
          }

          return forkJoin(allSubjectType.map(singleType =>
              this.bangumiSearchService.searchSubject(keywords, singleType.toString(),
                responseGroup, start, max_results === undefined ? 5 : max_results)
            )
          );
        }),
      )
      .subscribe(res => {
        this.subjectSearchResult = res;
      });
  }


  /**
   * map a enum type into relevant string
   * @param {number} type
   * @returns {string}
   */
  getTypeName(type: number): string {
    switch (type) {
      case SubjectType.book : {
        return _('search.category.book');
      }
      case SubjectType.anime : {
        return _('search.category.anime');
      }
      case SubjectType.music : {
        return _('search.category.music');
      }
      case SubjectType.game : {
        return _('search.category.game');
      }
      case SubjectType.real : {
        return _('search.category.real');
      }
      default : {
        return _('search.category.all');
      }
    }
  }


}
