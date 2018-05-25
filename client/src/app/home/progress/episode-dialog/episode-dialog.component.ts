import {Component, Inject, OnInit} from '@angular/core';
import {ProgressComponent} from '../progress.component';
import {MAT_DIALOG_DATA, MatDialogRef} from '@angular/material';
import {Episode} from '../../../shared/models/episode/episode';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import {EpisodeCollectionStatus} from '../../../shared/enums/episode-collection-status';

@Component({
  selector: 'app-episode-dialog',
  templateUrl: './episode-dialog.component.html',
  styleUrls: ['./episode-dialog.component.scss']
})
export class EpisodeDialogComponent implements OnInit {

  private episodeForm: FormGroup;
  episodeCollectionStatus: EpisodeCollectionStatus;

  constructor(public dialogRef: MatDialogRef<ProgressComponent>,
              @Inject(MAT_DIALOG_DATA) public episode: Episode,
              private formBuilder: FormBuilder) { }

  ngOnInit() {
    this.createForm();
  }

  createForm() {

    this.episodeForm = this.formBuilder.group(
      {
        'collectionStatus': [<string>EpisodeCollectionStatus[this.episode.userCollectionStatus], []],
      }
    );
  }








}
