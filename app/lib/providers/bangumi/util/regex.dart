final RegExp daysRegexEn = RegExp(r'(\d+)d');
final RegExp hoursRegexEn = RegExp(r'(\d+)h');
final RegExp minutesRegexEn = RegExp(r'(\d+)m');
final RegExp secondsRegexEn = RegExp(r'(\d+)s');

final RegExp yearsRegexZhHans = RegExp(r'(\d+)年');
final RegExp monthsRegexZhHans = RegExp(r'(\d+)月');
final RegExp daysRegexZhHans = RegExp(r'(\d+)天');
final RegExp hoursRegexZhHans = RegExp(r'(\d+)小时');
final RegExp minutesRegexZhHans = RegExp(r'(\d+)分');
final RegExp secondsRegexZhHans = RegExp(r'(\d+)秒');

/// matches date like 2019-4-8
final RegExp unnormalizedDateMatcher = RegExp(r'-(\d)(?=[-\s])');

final RegExp cssBackgroundImageGroupRegex =
    RegExp(r"""background-image:url\('([^']*)'\)""");
final RegExp validBangumiImageTypeRegex = RegExp(r'\.jpg|\.png');
final RegExp endsWithWordsRegex = RegExp(r'\w+$');
final RegExp endsWithAlphanumericGroupRegex = RegExp(r'([a-zA-Z0-9]+)$');

final RegExp endsWithDigitRegex = RegExp(r'\d+$');
final RegExp endsWithDigitGroupRegex = RegExp(r'(\d+)$');
final RegExp atLeastOneDigitRegex = RegExp(r'\d+');
final RegExp atLeastOneDigitGroupRegex = RegExp(r'(\d+)');

/// User avatar stores in path like
/// lain.bgm.tv/pic/user/s/000/00/1/12345.jpg?r=1550000000
/// `12345` is the user id
final RegExp userIdInAvatarGroupRegex = RegExp(r'(\d+)\.jpg');

final RegExp atLeastOneSpaceRegex = RegExp(r'\s+');
final RegExp endsOrStartsWithSpaceRegex = RegExp(r'^\s+|\s+$');

final RegExp scoreRegex = RegExp(r's?stars(\d+)');

final RegExp contentAfterFistColonGroupRegex = RegExp(r':(.*)');

final RegExp blockedUserIdGroupRegex =
    RegExp(r'privacy\?ignore_reset=(\d+)&gh=');

final RegExp userAgentDummyStringRegex = RegExp(r'^"|"$');
