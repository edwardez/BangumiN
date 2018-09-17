// some common utilities
import {SubjectType} from '../enums/subject-type.enum';

export class CommonUtils {

  /**
   * a in-place mutation method which copies property that only exists
   * on source object under a target property called "customizedProperties"
   * @param {Object} source source object
   * @param {Object} target target object
   * @returns {any} mutated target object
   */
  public static copyCustomizedProperties(source: Object, target: Object): any {

    target['customizedProperties'] = {};

    for (const currentProperty of Object.keys(source)) {
      if (!(currentProperty in target)) {
        target['customizedProperties'][currentProperty] = source[currentProperty];
      }
    }

    return target;
  }

  /**
   * Get mat-icon string representation that's associated with the subject type
   * @param subjectType enum, subject type
   */
  static getSubjectIcon(subjectType: SubjectType): string {
    let subjectMatIcon;
    switch (subjectType) {
      case SubjectType.anime:
        subjectMatIcon = 'live_tv';
        break;
      case SubjectType.book:
        subjectMatIcon = 'book';
        break;
      case SubjectType.music:
        subjectMatIcon = 'music_note';
        break;
      case SubjectType.game:
        subjectMatIcon = 'videogame_asset';
        break;
      case SubjectType.real:
        subjectMatIcon = 'tv';
        break;
      default:
        // use help_outline as a 'question mark' as material icon doesn't have a question mark
        subjectMatIcon = 'help_outline';
        break;
    }
    return subjectMatIcon;
  }
}
