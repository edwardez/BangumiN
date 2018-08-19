import {Component, OnInit} from '@angular/core';
import {MatDialog} from '@angular/material';
import {SpoilerCreationComponent} from '../spoiler-creation/spoiler-creation.component';
import {ResponsiveDialogService} from '../../../../shared/services/dialog/responsive-dialog.service';
import Quill from 'quill';

const Clipboard = Quill.import('modules/clipboard');
const Delta = Quill.import('delta');

class PlainClipboard extends Clipboard {
  convert(html = null) {
    if (typeof html === 'string') {
      this.container.innerHTML = html;
    }
    const text = this.container.innerText;
    this.container.innerHTML = '';
    return new Delta().insert(text);
  }
}

Quill.register('modules/clipboard', PlainClipboard, true);

@Component({
  selector: 'app-spoiler-overview',
  templateUrl: './spoiler-overview.component.html',
  styleUrls: ['./spoiler-overview.component.scss']
})
export class SpoilerOverviewComponent implements OnInit {

  quillModules = {};


  constructor(private dialog: MatDialog,
              private spoilerCreationDialogService: ResponsiveDialogService,
  ) {
  }


  ngOnInit() {



    //
    // this.quillModules = {
    //   formula: true,
    //   toolbar: '#quill-editor-toolbar',
    // };
    setTimeout(() => {
      this.openDialog();
    }, 100);
  }

  openDialog(): void {
    // this.dialog.open(SpoilerCreationComponent);
    const dialogRef = this.spoilerCreationDialogService.openDialog(SpoilerCreationComponent, {
      sizeConfig: {
        onLtSmScreen: {
          width: '50%',
          height: '50%',
        }
      }
    }).subscribe();
  }

}
