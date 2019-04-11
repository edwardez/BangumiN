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
