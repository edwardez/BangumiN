import {Component, OnDestroy, OnInit} from '@angular/core';
import {ActivatedRoute} from '@angular/router';
import {filter, switchMap, takeUntil} from 'rxjs/operators';
import {Subject} from 'rxjs';
import {BanguminSpoilerService} from '../../../../../shared/services/bangumin/bangumin-spoiler.service';

@Component({
  selector: 'app-spoiler-single-wrapper',
  templateUrl: './spoiler-single-wrapper.component.html',
  styleUrls: ['./spoiler-single-wrapper.component.scss']
})
export class SpoilerSingleWrapperComponent implements OnInit, OnDestroy {

  spoilerContent;
  private ngUnsubscribe: Subject<void> = new Subject<void>();

  constructor(private activatedRoute: ActivatedRoute,
              private banguminSpoilerService: BanguminSpoilerService,) {
  }

  ngOnInit() {
    this.activatedRoute
      .params
      .pipe(
        takeUntil(this.ngUnsubscribe),
        filter(params => params['userId'] && params['spoilerId']),
        switchMap(params => {
            const userId = params['userId'];
            const spoilerId = params['spoilerId'];
            return this.banguminSpoilerService.getSpoiler(userId, spoilerId);
          },
        ))
      .subscribe(res => {
        this.spoilerContent = res;
      });
  }

  ngOnDestroy(): void {
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

}
