import {Injectable} from '@angular/core';
import {SpoilerTextChunkSchema} from '../../models/spoiler/spoiler-base';
import {map, switchMap, take} from 'rxjs/operators';
import {TranslateService} from '@ngx-translate/core';
import {Observable} from 'rxjs';
import {SnackBarService} from '../snackBar/snack-bar.service';


export interface CopyEvent {
  isSuccess: boolean;
  content?: string;
}


@Injectable({
  providedIn: 'root'
})
export class ShareableStringGeneratorService {

  static encodedHashSign = encodeURIComponent('#');

  constructor(private translateService: TranslateService,
              private snackBarService: SnackBarService) {
  }

  /**
   * Count length of a string on social platform, s
   * @param rawString
   * @see {@link sliceString(string, number)}
   */
  static countStringLength(rawString) {
    let count = 0;
    for (let i = 0, len = rawString.length; i < len; i++) {
      count += rawString.charCodeAt(i) < 256 ? 1 : 2;
    }
    return count;
  }

  /**
   * Description: Slice a string (mixing English and Chinese characters) with the specified length.
   * Twitter counts charCode >= 256 as two string while js count all of them as 1, hence this method is needed
   * A basic and rough function.
   * Modified from https://gist.github.com/Alex1990/306422612ede27235c73
   * Performance:
   *      Multiple methods performance test on http://jsperf.com/count-string-length.
   *      You can see that using regexp to check range is very slow from the above test page.
   */
  static sliceString(rawString: string, maxStringLength: number) {
    let count = 0;
    for (let i = 0, len = rawString.length; i < len; i++) {
      count += rawString.charCodeAt(i) < 256 ? 1 : 2;
      if (count === maxStringLength) {
        return rawString.slice(0, i + 1);
      } else if (count > maxStringLength) {
        return rawString.slice(0, i);
      }
    }
    return rawString;
  }

  /**
   * convert quill format text to masked text
   * @param spoilerText
   */
  static spoilerDeltaToMaskedRawText(spoilerText: SpoilerTextChunkSchema[]): string {
    const mask = '◯';
    return spoilerText.map((spoilerTextChunk: SpoilerTextChunkSchema) => {
      if (spoilerTextChunk.attributes && spoilerTextChunk.attributes.spoiler) {
        return spoilerTextChunk.insert.replace(/./g, mask);
      }

      return spoilerTextChunk.insert;
    }).join('');
  }


  /**
   * generate and slice text which can be shared on weibo
   * @param relatesSubjectsNames relatesSubjectsNames
   * @param spoilerLink link
   * @param spoilerText text in quill format
   */
  generateWeiboShareLink(relatesSubjectsNames: string[], spoilerLink: string, spoilerText: SpoilerTextChunkSchema[]): Observable<string> {
    return this.translateService
      .get('common.noun.spoiler')
      .pipe(
        map(spoilerLabel => {
          const hashTagsConsecutiveString: string = relatesSubjectsNames.map(
            hashTag => ShareableStringGeneratorService.encodedHashSign + (hashTag || '') + ShareableStringGeneratorService.encodedHashSign)
            .join(' ');
          const maskedRawText = ShareableStringGeneratorService.spoilerDeltaToMaskedRawText(spoilerText);
          const generatedShareableText = spoilerLabel + ': ' + hashTagsConsecutiveString + ' ' + maskedRawText;
          // weibo will automatically slice string so we don't need to precisely calculate
          // however weibo will return code 414(url too long) if the spoiler content is too long, slice the string to 140
          return encodeURI(
            `https://service.weibo.com/share/share.php?url=${spoilerLink}&title=${generatedShareableText.slice(0, 140)}&content=utf-8`);
        }),
        take(1),
      );

  }

  /**
   * generate and slice text which can be shared on twitter
   * @param relatesSubjectsNames relatesSubjectsNames
   * @param spoilerLink link
   * @param spoilerText text in quill format
   */
  generateTwitterShareLink(relatesSubjectsNames: string[], spoilerLink: string, spoilerText: SpoilerTextChunkSchema[]): Observable<string> {
    return this.translateService
      .get('common.noun.spoiler')
      .pipe(
        map(spoilerLabel => {
          const hashTags = [spoilerLabel, ...relatesSubjectsNames];
          const linkLength = 23; // max length of t.co link, currently it's 23, use 25 as a buffer
          // hashTags.length * 3: space between hashTag, length of #
          const maxTextLength = 280 - linkLength - ShareableStringGeneratorService.countStringLength(hashTags.join('')) - hashTags.length *
            3;
          const maskedRawText = ShareableStringGeneratorService.spoilerDeltaToMaskedRawText(spoilerText);
          return encodeURI(
            `https://twitter.com/intent/tweet?url=${spoilerLink}&text=${ShareableStringGeneratorService.sliceString(maskedRawText,
              maxTextLength)}&hashtags=${hashTags.join(',')}`);
        }),
        take(1),
      );
  }

  /**
   * A general method to generate the masked copyable text
   * @param relatesSubjectsNames relatesSubjectsNames
   * @param spoilerLink link
   * @param spoilerText text in quill format
   */
  generateCopyableText(relatesSubjectsNames: string[], spoilerLink: string, spoilerText: SpoilerTextChunkSchema[]): Observable<string> {
    return this.translateService
      .get('common.noun.spoiler')
      .pipe(
        map(spoilerLabel => {
          // if default language of user is zh-Hans, we assume user is more likely to use weibo to share and generate weibo style hashTag
          const hashTagsConsecutiveString: string = relatesSubjectsNames.map(
            hashTag => '#' + (hashTag || '') + (this.translateService.currentLang === 'zh-Hans' ? '#' : ''))
            .join(' ');
          const maskedRawText = ShareableStringGeneratorService.spoilerDeltaToMaskedRawText(spoilerText);
          return spoilerLabel + ': ' + hashTagsConsecutiveString + ' ' + maskedRawText + '\n' + spoilerLink;
        }),
        take(1),
      );
  }

  /**
   * Handle the copy callback, if the result is successfull, pop up a snack bar message
   * else open content in new window
   * @param event CopyEvent
   * @param copyableText copyableText
   * @param spoilerLink link of the spoiler
   */
  handleCopyCallback(event: CopyEvent, copyableText: Observable<string>, spoilerLink: string): Observable<any> {
    if (event.isSuccess) {
      return this.snackBarService.openSimpleSnackBar('common.snackBar.success.copy.result');
    } else {
      return this.snackBarService.openSimpleSnackBar('common.snackBar.error.copy.then.openNewWindow')
        .pipe(
          switchMap(res => copyableText),
          map(text => {
            return window.open('').document.open('data:text/plain;charset=utf-8').write(text);
          }),
          take(1),
        );
    }
  }
}
