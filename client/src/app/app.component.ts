import {Component, OnInit, ViewChild} from '@angular/core';
import {MatSidenav} from '@angular/material';
import {SidenavService} from './shared/services/sidenav.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit{

  @ViewChild('sidenav') public sidenav: MatSidenav;
  mode = 'side';
  title = 'BangumiN';

  ngOnInit(): void {
    this.sidenavService
      .setSidenav(this.sidenav);
  }

  constructor(private sidenavService: SidenavService) {

  }


}
