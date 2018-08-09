import {Component, OnInit} from '@angular/core';

@Component({
  selector: 'app-bangumin-posts',
  templateUrl: './bangumin-posts.component.html',
  styleUrls: ['./bangumin-posts.component.scss']
})
export class BanguminPostsComponent implements OnInit {

  modules = false;

  constructor() {
  }

  ngOnInit() {
    setTimeout(() => {
      this.modules = true;
    }, 2000);
  }

}
