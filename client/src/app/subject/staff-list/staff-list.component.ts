import {Component, Input, OnInit} from '@angular/core';

@Component({
  selector: 'app-staff-list',
  templateUrl: './staff-list.component.html',
  styleUrls: ['./staff-list.component.scss']
})
export class StaffListComponent implements OnInit {

  @Input()
  subject;

  constructor() {
  }

  ngOnInit() {
  }

}
