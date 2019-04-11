import 'package:intl/intl.dart';
import 'package:quiver/time.dart';
import 'package:timeago/timeago.dart' as timeago;

class TimeUtils {
  static const defaultRelativeTimeFormatName = 'zh_hans_short';
  static final DateFormat defaultAbsoluteTimeFormatter =
      DateFormat('yyyy-MM-dd HH:mm');

  static initializeTimeago() {
    timeago.setLocaleMessages(
        defaultRelativeTimeFormatName, _ZhHansMessagesShort());
  }

  /// Format a millie seconds epoch time to 'xx ago'
  /// If [epochTimeInMilliSeconds] is null, [fallbackTimeStr] will be returned
  /// If difference between current time and [relativeTimeThreshold] is longer than
  /// [relativeTimeThreshold], it'll be displayed absolute time
  /// [relativeTimeFormat] must be valid format in [timeago]
  static String formatMilliSecondsEpochTime(int epochTimeInMilliSeconds,
      {absoluteTimeFormatter,
      fallbackTimeStr = '神秘时间',
      relativeTimeFormat = defaultRelativeTimeFormatName,
      relativeTimeThreshold = aDay}) {
    if (epochTimeInMilliSeconds == null) {
      return fallbackTimeStr;
    }

    if (absoluteTimeFormatter == null) {
      absoluteTimeFormatter = defaultAbsoluteTimeFormatter;
    }

    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(epochTimeInMilliSeconds);

    if (DateTime.now().difference(dateTime) > relativeTimeThreshold) {
      return absoluteTimeFormatter.format(dateTime);
    }

    return timeago.format(dateTime, locale: relativeTimeFormat);
  }
}

class _ZhHansMessagesShort implements timeago.LookupMessages {
  String prefixAgo() => '';

  String prefixFromNow() => '不久以前';

  String suffixAgo() => '前';

  String suffixFromNow() => '后';

  String lessThanOneMinute(int seconds) => '少于一分钟';

  String aboutAMinute(int minutes) => '1分钟';

  String minutes(int minutes) => '$minutes分钟';

  String aboutAnHour(int minutes) => '1小时';

  String hours(int hours) => '$hours小时';

  String aDay(int hours) => '1天';

  String days(int days) => '$days日';

  String aboutAMonth(int days) => '1个月';

  String months(int months) => '$months月';

  String aboutAYear(int year) => '1年';

  String years(int years) => '$years年';

  String wordSeparator() => '';
}
