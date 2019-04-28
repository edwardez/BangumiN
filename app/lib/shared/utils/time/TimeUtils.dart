import 'package:intl/intl.dart';
import 'package:quiver/time.dart';
import 'package:timeago/timeago.dart' as timeago;

enum DisplayTimeIn { AlwaysRelative, AlwaysAbsolute, SwitchByThreshold }

enum AbsoluteTimeFormat { Full, DateOnly }

class TimeUtils {
  static const defaultRelativeTimeFormatName = 'zh_hans_short';
  static final DateFormat fullAbsoluteTimeFormatter =
      DateFormat('yyyy-MM-dd HH:mm');
  static final DateFormat dateOnlyAbsoluteTimeFormatter =
  DateFormat('yyyy-MM-dd');

  static initializeTimeago() {
    timeago.setLocaleMessages(
        defaultRelativeTimeFormatName, _ZhHansMessagesShort());
  }

  /// Format a millie seconds epoch time to 'xx ago'
  /// If [epochTimeInMilliSeconds] is null, [fallbackTimeStr] will be returned
  /// [relativeTimeFormat] must be valid format in [timeago]
  /// If [displayTimeIn] is set to [DisplayTimeIn.AlwaysRelative], relative time will
  /// always be used
  /// If [displayTimeIn] is set to [DisplayTimeIn.AlwaysAbsolute], absolute time will
  /// always be used
  /// If [displayTimeIn] is set to [DisplayTimeIn.SwitchByThreshold], both time might
  /// be displayed, it depends on [[relativeTimeThreshold]]. Specifiably, If
  /// difference between current time and [epochTimeInMilliSeconds] are longer than
  /// [relativeTimeThreshold], absolute time  will be displayed, otherwise
  /// relative time will be displayed
  static String formatMilliSecondsEpochTime(int epochTimeInMilliSeconds, {
    displayTimeIn = DisplayTimeIn.SwitchByThreshold,
    AbsoluteTimeFormat formatAbsoluteTimeAs = AbsoluteTimeFormat.Full,
    fallbackTimeStr = '神秘时间',
    relativeTimeFormat = defaultRelativeTimeFormatName,
    relativeTimeThreshold = aDay,
  }) {
    if (epochTimeInMilliSeconds == null) {
      return fallbackTimeStr;
    }

    DateFormat absoluteTimeFormatter;
    if (formatAbsoluteTimeAs == AbsoluteTimeFormat.DateOnly) {
      absoluteTimeFormatter = dateOnlyAbsoluteTimeFormatter;
    } else {
      absoluteTimeFormatter = fullAbsoluteTimeFormatter;
    }

    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(epochTimeInMilliSeconds);

    if (displayTimeIn == DisplayTimeIn.AlwaysAbsolute) {
      return absoluteTimeFormatter.format(dateTime);
    }

    if (displayTimeIn == DisplayTimeIn.AlwaysRelative) {
      return timeago.format(dateTime, locale: relativeTimeFormat);
    }

    /// Otherwise, [timeDisplayFormat] is set to [TimeDisplayFormat.SwitchByThreshold]
    /// Or an unknown enum value is passed in so we have to use default display format
    assert(displayTimeIn == DisplayTimeIn.SwitchByThreshold);

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

  String days(int days) => '$days天';

  String aboutAMonth(int days) => '1个月';

  String months(int months) => '$months个月';

  String aboutAYear(int year) => '1年';

  String years(int years) => '$years年';

  String wordSeparator() => '';
}
