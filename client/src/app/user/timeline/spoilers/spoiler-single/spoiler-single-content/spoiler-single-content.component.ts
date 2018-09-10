import {Component, Input, OnInit} from '@angular/core';
import {SpoilerTextChunkSchema} from '../../../../../shared/models/spoiler/spoiler-base';
import {SpoilerExisted} from '../../../../../shared/models/spoiler/spoiler-existed';
import {RuntimeConstantsService} from '../../../../../shared/services/runtime-constants.service';
import {environment} from '../../../../../../environments/environment';
import {BangumiUser} from '../../../../../shared/models/BangumiUser';
import {TranslateService} from '@ngx-translate/core';

@Component({
  selector: 'app-spoiler-single-content',
  templateUrl: './spoiler-single-content.component.html',
  styleUrls: ['./spoiler-single-content.component.scss']
})
export class SpoilerSingleContentComponent implements OnInit {

  @Input()
  bangumiUser: BangumiUser;

  spoilerContentReceived: SpoilerExisted;
  spoilerHtml: string;
  currentLanguage: string;
  defaultSubjectId = RuntimeConstantsService.defaultSubjectId;

  constructor(private translateService: TranslateService) {
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


}
