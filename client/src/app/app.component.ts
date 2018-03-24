import {Component, OnInit, ViewChild} from '@angular/core';
import {MatSidenav} from '@angular/material';
import {SidenavService} from './shared/services/sidenav.service';
import {TranslateService} from '@ngx-translate/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit {

  @ViewChild('sidenav') public sidenav: MatSidenav;
  mode = 'side';
  title = 'BangumiN';

  constructor(private sidenavService: SidenavService,
              private translate: TranslateService) {

    this.setDefaultLanguage(translate);
  }

  ngOnInit(): void {
    this.sidenavService
      .setSidenav(this.sidenav);
  }

  setDefaultLanguage(translate) {
    translate.addLangs(['en-US', 'zh-Hans']);
    const browserLang = this.translate.getBrowserLang();
    let defaultLang: string;
    if (browserLang.match(/en/)) {
      defaultLang = 'en-US';
    } else if (browserLang.match(/zh/)) {
      defaultLang = 'zh-Hans';
    }
    translate.setDefaultLang(defaultLang);
    this.translate.use(defaultLang);
  }


}
