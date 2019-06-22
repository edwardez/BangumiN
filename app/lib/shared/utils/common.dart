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

/// Parses bool in string format, returns  [defaultValue] if input is invalid.
bool tryParseBool(
  String inputStr, {
  bool defaultValue,
}) {
  if (inputStr == null) return null;

  if (inputStr.toLowerCase() == false.toString()) {
    return false;
  }

  if (inputStr.toLowerCase() == true.toString()) {
    return true;
  }

  return defaultValue;
}

/// safely parse an double string, or returns null if doubleStr is null
/// if doubleStr is not double string, [defaultValue] will be returned
double tryParseDouble(String doubleStr, {defaultValue = 0}) {
  if (doubleStr == null) {
    return defaultValue;
  }
  return double.tryParse(doubleStr) ?? defaultValue;
}

/// Returns first captures string or null
/// [input] should never be null, if it's null, null will be returned
/// This method assumes [regExp] contains at least one capture group
String firstCapturedStringOrNull(RegExp regExp, String input) {
  /// Ensure input [regExp] contains at least one capture group
  assert(RegExp(r'\(.+\)').hasMatch(regExp.pattern));
  assert(input != null);

  if (input == null) {
    return null;
  }

  Match match = regExp.firstMatch(input);

  if (match != null && match.groupCount >= 1) {
    return match.group(1);
  }

  return null;
}

bool doubleIsInt(double input) {
  if (input == null) return false;
  return input % 1 == 0;
}

/// Tries to format a double like `1.0`
String tryFormatDoubleAsInt(double input) {
  if (doubleIsInt(input)) {
    return input.toStringAsFixed(0);
  }

  return input.toString();
}

/// https://www.dartlang.org/articles/server/numeric-computation
/// Dart doesn't provide max / min int by default, max/min safe integer for js
/// is used here
class IntegerHelper {
  static const MAX_VALUE = 9007199254740991;
  static const MIN_VALUE = -9007199254740991;
}
