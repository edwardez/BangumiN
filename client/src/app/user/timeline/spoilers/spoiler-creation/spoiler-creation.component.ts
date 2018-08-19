import {Component, OnInit} from '@angular/core';
import {AuthenticationService} from '../../../../shared/services/auth.service';
import {take} from 'rxjs/operators';
import {BangumiUser} from '../../../../shared/models/BangumiUser';

import Quill from 'quill';

const Inline = Quill.import('blots/inline');

class SpoilerBolt extends Inline {
  static create(url) {
    const node = super.create();

    node.setAttribute('class', 'background-color-bangumin-theme-accent');
    node.setAttribute('style', 'color: red');
    return node;
  }
}

SpoilerBolt.blotName = 'spoiler';
SpoilerBolt.tagName = 'span';


Quill.register(SpoilerBolt);

const icons = Quill.import('ui/icons');
icons['clean'] = '<mat-icon class="mat-icon material-icons">visibility</mat-icon>';

@Component({
  selector: 'app-spoiler-creation',
  templateUrl: './spoiler-creation.component.html',
  styleUrls: ['./spoiler-creation.component.scss']
})
export class SpoilerCreationComponent implements OnInit {
  bangumiUser: BangumiUser;
  quill: Quill;

  constructor(private authenticationService: AuthenticationService) {
  }

  ngOnInit() {

    this.authenticationService.userSubject.pipe(
      take(1)
    ).subscribe((bangumiUser: BangumiUser) => {
        this.bangumiUser = bangumiUser;
      }
    );
  }

  addBold(event) {
    this.quill.format('spoiler', true);
  }

  setEditor(quill: Quill) {
    this.quill = quill;
  }

}
