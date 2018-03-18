import {Component, OnInit, ViewChild} from '@angular/core';
import {MatSidenav} from '@angular/material';
import {SidenavService} from '../../shared/services/sidenav.service';

@Component({
  selector: 'app-side-nav',
  templateUrl: './side-nav.component.html',
  styleUrls: ['./side-nav.component.scss']
})
export class SideNavComponent implements OnInit {

  @ViewChild('sidenav') public sidenav: MatSidenav;
  mode = 'side';

  constructor(private sidenavService: SidenavService) { }

  ngOnInit() {
    // store sidenav to service
    this.sidenavService
      .setSidenav(this.sidenav);
  }

}
