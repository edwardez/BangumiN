import {Component, Input, OnInit} from '@angular/core';
import {SpoilerNew} from '../../../../../shared/models/spoiler/spoiler-new';
import {SpoilerTextChunkSchema} from '../../../../../shared/models/spoiler/spoiler-base';

@Component({
  selector: 'app-spoiler-single-content',
  templateUrl: './spoiler-single-content.component.html',
  styleUrls: ['./spoiler-single-content.component.scss']
})
export class SpoilerSingleContentComponent implements OnInit {

  @Input()
  spoilerContent: SpoilerNew;

  spoilerHtml: string;

  constructor() {
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
    this.spoilerHtml = SpoilerSingleContentComponent.spoilerDeltaToHtml(this.spoilerContent.spoilerText);
  }


}
