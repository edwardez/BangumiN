import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-nav',
  templateUrl: './nav.component.html',
  styleUrls: ['./nav.component.scss']
})
export class NavComponent implements OnInit {

  imgSrc = 'http://lain.bgm.tv/pic/user/l/000/00/00/1.jpg?r=1391790456';

  constructor() { }

  ngOnInit() {
  }

}
