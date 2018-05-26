import {Component, OnInit, ViewChild} from '@angular/core';
import {MatSidenav} from '@angular/material';
import {SidenavService} from '../../shared/services/sidenav.service';

@Component({
    selector: 'app-side-nav-content',
    templateUrl: './side-nav-content.component.html',
    styleUrls: ['./side-nav-content.component.scss']
})
export class SideNavContentComponent implements OnInit {

    @ViewChild('sidenav') public sidenav: MatSidenav;
    mode = 'side';

    constructor(private sidenavService: SidenavService) {
    }

    ngOnInit() {
        this.sidenavService
            .setSidenav(this.sidenav);
    }

}
