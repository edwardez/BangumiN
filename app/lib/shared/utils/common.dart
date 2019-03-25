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
/// if intStr is not int string, [defaultValue] will be returned
int tryParseInt(String intStr, {defaultValue = 0}) {
  if (intStr == null) {
    return defaultValue;
  }
  return int.tryParse(intStr) ?? defaultValue;
}

/// safely parse an double string, or returns null if doubleStr is null
/// if doubleStr is not double string, [defaultValue] will be returned
double tryParseDouble(String doubleStr, {defaultValue = 0}) {
  if (doubleStr == null) {
    return defaultValue;
  }
  return double.tryParse(doubleStr) ?? defaultValue;
}

/// https://www.dartlang.org/articles/server/numeric-computation
/// Dart doesn't provide max / min int by default, max/min safe integer for js
/// is used here
class IntegerHelper {
  static const MAX_VALUE = 9007199254740991;
  static const MIN_VALUE = -9007199254740991;
}
