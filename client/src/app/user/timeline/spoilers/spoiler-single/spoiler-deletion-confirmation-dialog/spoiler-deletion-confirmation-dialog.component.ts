import {Component, Inject, OnInit} from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import {SpoilerExisted} from '../../../../../shared/models/spoiler/spoiler-existed';
import {BanguminSpoilerService} from '../../../../../shared/services/bangumin/bangumin-spoiler.service';
import {AuthenticationService} from '../../../../../shared/services/auth.service';
import {switchMap} from 'rxjs/operators';
import {Router} from '@angular/router';


@Component({
  selector: 'app-spoiler-deletion-confirmation-dialog',
  templateUrl: './spoiler-deletion-confirmation-dialog.component.html',
  styleUrls: ['./spoiler-deletion-confirmation-dialog.component.scss']
})
export class SpoilerDeletionConfirmationDialogComponent implements OnInit {

  constructor(
    private authenticationService: AuthenticationService,
    private banguminSpoilerService: BanguminSpoilerService,
    private router: Router,
    public dialogRef: MatDialogRef<SpoilerDeletionConfirmationDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public spoilerExisted: SpoilerExisted) {
  }

  ngOnInit() {
  }

  onCancelClick() {
    this.dialogRef.close();
  }

  onConfirmClick() {
    this.banguminSpoilerService
      .deleteSpoiler(this.spoilerExisted.spoilerId, String(this.spoilerExisted.userId))
      .pipe(
        switchMap(res => this.authenticationService.userSubject)
      )
      .subscribe(
        userSubject => {
          // TODO: handle logic after deleting
          // this.router.navigate('../', )
          if (userSubject && userSubject.id && this.spoilerExisted.spoilerId) {
            // navigate user to the home spoiler page
            this.router.navigate(['../', 'user', userSubject.id, 'timeline', 'spoilers']);
            this.dialogRef.close();
          } else {
            // unauthenticated users should not be able to delete, this shouldn't happen, if it happens, we force refreshing the page
            window.location.reload();
          }
        }
      );
  }

}
