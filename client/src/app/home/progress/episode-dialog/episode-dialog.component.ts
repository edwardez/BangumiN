import {Component, Inject, OnInit} from '@angular/core';
import {ProgressComponent} from '../progress.component';
import {MAT_DIALOG_DATA, MatDialogRef} from '@angular/material';
import {Episode} from '../../../shared/models/episode/episode';
import {FormBuilder, FormGroup} from '@angular/forms';
import {EpisodeCollectionStatus} from '../../../shared/enums/episode-collection-status';
import {BangumiCollectionService} from '../../../shared/services/bangumi/bangumi-collection.service';
import {SubjectWatchingCollectionMedium} from '../../../shared/models/subject/subject-watching-collection-medium';
import {environment} from '../../../../environments/environment';

@Component({
  selector: 'app-episode-dialog',
  templateUrl: './episode-dialog.component.html',
  styleUrls: ['./episode-dialog.component.scss']
})
export class EpisodeDialogComponent implements OnInit {

  private episodeStatusForm: FormGroup;
  eps = EpisodeCollectionStatus;

  constructor(public dialogRef: MatDialogRef<ProgressComponent>,
              @Inject(MAT_DIALOG_DATA) public collectionInfo:
                { episode: Episode, subject: SubjectWatchingCollectionMedium },
              private formBuilder: FormBuilder,
              private bangumiCollectionService: BangumiCollectionService) {
  }

  ngOnInit() {
    this.createForm();
  }

  createForm() {
    this.episodeStatusForm = this.formBuilder.group(
      {
        'collectionStatus': [this.collectionInfo.episode.userCollectionStatus, []],
      }
    );
  }


  onSubmitValueChange() {
    const episodeStatusModel = this.episodeStatusForm.value;
    if ([EpisodeCollectionStatus.queue, EpisodeCollectionStatus.watched,
      EpisodeCollectionStatus.drop, EpisodeCollectionStatus.remove].indexOf(episodeStatusModel.collectionStatus) !== -1) {
      this.bangumiCollectionService.upsertEpisodeStatus(this.collectionInfo.episode.id,
        EpisodeCollectionStatus[episodeStatusModel.collectionStatus])
        .subscribe(response => {
          this.dialogRef.close({'collectionStatus': episodeStatusModel.collectionStatus, 'response': response});
        });
    }
  }


  get episodeCollectionStatus() {
    return EpisodeCollectionStatus;
  }


}
