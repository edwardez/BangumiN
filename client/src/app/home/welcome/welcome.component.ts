import {Component, OnInit} from '@angular/core';
import {TitleService} from '../../shared/services/page/title.service';

@Component({
  selector: 'app-welcome',
  templateUrl: './welcome.component.html',
  styleUrls: ['./welcome.component.scss']
})
export class WelcomeComponent implements OnInit {

  constructor(private titleService: TitleService) {
  }

  ngOnInit() {
    this.titleService.setTitleByTranslationLabel('welcome.name');
  }

}
