import {Component, Input, OnInit, Renderer2} from '@angular/core';
import {BanguminUserSummaryService} from '../../shared/services/bangumin/bangumin-user-summary.service';

@Component({
  selector: 'app-user-summary',
  templateUrl: './user-summary.component.html',
  styleUrls: ['./user-summary.component.scss']
})
export class UserSummaryComponent implements OnInit {

  @Input()
  username: any;

  constructor(private banguminUserSummaryService: BanguminUserSummaryService,
              private renderer: Renderer2) {

  }

  ngOnInit() {
  }

  onIntersection({target, visible}: { target: Element; visible: boolean }) {

    const addClass = visible ? 'active' : 'inactive';
    this.renderer.addClass(target, addClass);

    const rmClass = visible ? 'inactive' : 'active';
    this.renderer.removeClass(target, rmClass);
  }

}
