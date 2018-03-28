import { Component, OnInit } from '@angular/core';
import {BangumiSearchService} from '../../shared/services/bangumi/bangumi-search.service';
import {ActivatedRoute} from '@angular/router';
import {concatAll, filter, map, mergeMap, switchMap, takeUntil} from 'rxjs/operators';
import {Observable} from 'rxjs/Observable';
import {from} from 'rxjs/observable/from';
import {forkJoin} from 'rxjs/observable/forkJoin';
import {of} from 'rxjs/observable/of';
import {SubjectType} from '../../shared/enums/subject-type.enum';

@Component({
  selector: 'app-full-search',
  templateUrl: './full-search.component.html',
  styleUrls: ['./full-search.component.scss']
})
export class FullSearchComponent implements OnInit {

  constructor(private bangumiSearchService: BangumiSearchService,
              private route: ActivatedRoute) { }

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
        filter( params => params['keywords'] !== undefined),
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

          return forkJoin(allSubjectType.map( singleType =>
              this.bangumiSearchService.searchSubject(keywords, singleType.toString(),
                responseGroup, start, max_results === undefined ? 5 : max_results)
            )
          );
        }),
      )
      .subscribe(res => {

      });
  }


}
