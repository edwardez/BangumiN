// upgrade a link to https
// TODO: use built_value custom serializer to handle this at parsing time
import 'dart:math' show min;

upgradeToHttps(String link) {
  if (link?.runtimeType != String) {
    return link;
  }

  return link.replaceFirst('http://', 'https://');
}

truncateStringTo(String stringToTruncate, maxLength) {
  if (stringToTruncate == null) return '';

  return stringToTruncate.substring(0, min(stringToTruncate.length, maxLength));
}
