import {Component, Input, OnInit} from '@angular/core';

@Component({
  selector: 'app-loading-spinner',
  templateUrl: './loading-spinner.component.html',
  styleUrls: ['./loading-spinner.component.scss']
})
export class LoadingSpinnerComponent implements OnInit {

  //  whether height of the spinner should be 100vh, or it shouldn't be set
  @Input()
  fullHeight = true;

  constructor() {
  }

  ngOnInit() {
  }

}
