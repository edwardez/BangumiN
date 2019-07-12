import {Component, Input, OnInit, ViewChild} from '@angular/core';
import {SpoilerTextChunkSchema} from '../../../../../shared/models/spoiler/spoiler-base';
import {SpoilerExisted} from '../../../../../shared/models/spoiler/spoiler-existed';
import {RuntimeConstantsService} from '../../../../../shared/services/runtime-constants.service';
import {environment} from '../../../../../../environments/environment';
import {BangumiUser} from '../../../../../shared/models/BangumiUser';
import {TranslateService} from '@ngx-translate/core';
import { MatBottomSheet } from '@angular/material/bottom-sheet';
import { MatMenuTrigger } from '@angular/material/menu';
import {DeviceWidth} from '../../../../../shared/enums/device-width.enum';
import {ShareBottomSheetComponent} from '../share-bottom-sheet/share-bottom-sheet.component';

@Component({
  selector: 'app-spoiler-single-content',
  templateUrl: './spoiler-single-content.component.html',
  styleUrls: ['./spoiler-single-content.component.scss']
})
export class SpoilerSingleContentComponent implements OnInit {

  @Input()
  bangumiUser: BangumiUser;

  @Input()
  deviceWidth: DeviceWidth;

  @ViewChild(MatMenuTrigger, {static: false}) matMenuTrigger: MatMenuTrigger;

  spoilerContentReceived: SpoilerExisted;
  spoilerHtml: string;
  currentLanguage: string;
  defaultSubjectId = RuntimeConstantsService.defaultSubjectId;

  constructor(private translateService: TranslateService,
              private bottomSheet: MatBottomSheet) {
  }

  get spoilerContent(): SpoilerExisted {
    return this.spoilerContentReceived;
  }

  @Input()
  set spoilerContent(spoilerContent: SpoilerExisted) {
    if (spoilerContent) {
      this.spoilerContentReceived = spoilerContent;
      this.spoilerHtml = SpoilerSingleContentComponent.spoilerDeltaToHtml(spoilerContent.spoilerText);
    }
  }

  static spoilerDeltaToHtml(spoilerText: SpoilerTextChunkSchema[]): string {
    const paragraphTagStart = '<p>';
    const paragraphTagEnd = '</p>';
    const spoilerSpanStart = `<span class="color-bangumin-theme-foreground spoiler-text background-color-bangumin-theme-accent">`;
    const spoilerSpanEnd = '</span>';
    const newLineTag = '<br/>';
    const generatedHtml = spoilerText.map((spoilerTextChunk: SpoilerTextChunkSchema) => {
      if (spoilerTextChunk.attributes && spoilerTextChunk.attributes.spoiler) {
        return `${spoilerSpanStart}${spoilerTextChunk.insert.replace(/\n/g, newLineTag)}${spoilerSpanEnd}`;
      }

      return spoilerTextChunk.insert.replace(/\n/g, newLineTag);
    }).join('');
    return paragraphTagStart + generatedHtml + paragraphTagEnd;
  }


  ngOnInit() {
    this.currentLanguage = this.translateService.currentLang;
  }

  // Convert a link from bangumi to BangumiN, for now a new window will be spawned
  convertToBangumiNLink(bangumiUrl: string): string {
    return bangumiUrl.replace(/^https?:\/\/bgm\.tv/, environment.FRONTEND_URL);
  }

  openBottomSheet(): void {
    this.bottomSheet.open(ShareBottomSheetComponent, {
      data: {
        spoilerLink: this.generateSpoilerLink(),
        spoilerContent: this.spoilerContentReceived,
      }
    });
  }

  generateSpoilerLink() {
    return `${window.location.origin}/user/${this.bangumiUser.id}/timeline/spoilers/${this.spoilerContentReceived.spoilerId}`;
  }


}
