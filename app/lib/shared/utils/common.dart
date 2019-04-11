import 'dart:math' show min, max;

String upgradeToHttps(String link) {
  if (link?.runtimeType != String) {
    return link;
  }

  return link.replaceFirst('http://', 'https://');
}

/// returns first N characters of a string, or
/// the whole string if its length is less than N
/// [fallbackValue] if [input] is null
String firstNChars(String input, int firstN, {String fallbackValue}) {
  assert(firstN >= 0);
  if (input == null) return fallbackValue;

  return input.substring(0, min(input.length, firstN));
}

/// returns last N characters of a string, or
/// the whole string if its length is less than N
/// [fallbackValue] if [input] is null
String lastNChars(String input, int lastN, {fallbackValue = ''}) {
  assert(lastN >= 0);
  if (input == null) return fallbackValue;
  int inputLength = input.length;
  return input.substring(max(0, inputLength - lastN), inputLength);
}

/// safely parse an int string, or returns null if intStr is null
/// if intStr is not int string, [defaultValue] will be returned
int tryParseInt(String intStr, {defaultValue = 0}) {
  if (intStr == null) {
    return defaultValue;
  }
  return int.tryParse(intStr) ?? defaultValue;
}

/// Returns first captures string or null
/// This method assumes [regExp] contains at least one capture group
String firstCapturedStringOrNull(RegExp regExp, String input) {
  /// Ensure input [regExp] contains at least one capture group
  assert(RegExp(r'\(.+\)').hasMatch(regExp.pattern));

  Match match = regExp.firstMatch(input);

  if (match != null && match.groupCount >= 1) {
    return match.group(1);
  }

  return null;
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
