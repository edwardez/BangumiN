// upgrade a link to https
// TODO: use built_value custom serializer to handle this at parsing time
import 'dart:math' show min;

String upgradeToHttps(String link) {
  if (link?.runtimeType != String) {
    return link;
  }

  return link.replaceFirst('http://', 'https://');
}

String truncateStringTo(String stringToTruncate, maxLength) {
  if (stringToTruncate == null) return '';

  return stringToTruncate.substring(0, min(stringToTruncate.length, maxLength));
}

/// safely parse an int string, or returns null if intStr is null
/// this method assumes intStr must be a int string
int parseInt(String intStr) {
  return intStr == null ? null : int.parse(intStr);
}

/// https://www.dartlang.org/articles/server/numeric-computation
/// Dart doesn't provide max / min int by default, max/min safe integer for js
/// is used here
class IntegerHelper {
  static const MAX_VALUE = 9007199254740991;
  static const MIN_VALUE = -9007199254740991;
}
