import { Component, OnInit } from '@angular/core';
import {BangumiCollectionService} from '../../shared/services/bangumi/bangumi-collection.service';

@Component({
  selector: 'app-progress',
  templateUrl: './progress.component.html',
  styleUrls: ['./progress.component.scss']
})
export class ProgressComponent implements OnInit {

  constructor(private bangumiCollectionService: BangumiCollectionService) {

  }

  ngOnInit() {
  }

}
