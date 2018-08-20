import {Component, OnInit} from '@angular/core';
import {MatDialog} from '@angular/material';
import {SpoilerCreationComponent} from '../spoiler-creation/spoiler-creation.component';
import {ResponsiveDialogService} from '../../../../shared/services/dialog/responsive-dialog.service';

@Component({
  selector: 'app-spoiler-overview',
  templateUrl: './spoiler-overview.component.html',
  styleUrls: ['./spoiler-overview.component.scss']
})
export class SpoilerOverviewComponent implements OnInit {

  constructor(private dialog: MatDialog,
              private spoilerCreationDialogService: ResponsiveDialogService,
  ) {
  }


  ngOnInit() {

    setTimeout(() => {
      this.openDialog();
    }, 100);
  }

  openDialog(): void {
    // this.dialog.open(SpoilerCreationComponent);
    const dialogRef = this.spoilerCreationDialogService.openDialog(SpoilerCreationComponent, {
      sizeConfig: {
        onLtSmScreen: {
          maxWidth: '50vw',
          maxHeight: '80vh',
        }
      }
    }).subscribe();
  }

}
