// some common utilities
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
}
