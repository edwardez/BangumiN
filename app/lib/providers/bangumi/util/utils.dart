import 'dart:core';
import 'dart:ui';

import 'package:html/dom.dart' show DocumentFragment, Element, Node, NodeList;
import 'package:munin/models/bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:munin/providers/bangumi/util/regex.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:quiver/core.dart';
import 'package:quiver/strings.dart';

String aHrefContains(String keyword) {
  return 'a[href*="$keyword"]';
}

/// retrieve image url from background-image css property
/// Note: instead of accessing this property directly, [Element.outerHtml] of the
///  element is used
String imageUrlFromBackgroundImage(Element imageElement,
    {defaultImageSrc = 'https://bgm.tv/img/no_icon_subject.png',
    checkImageExtensionType = true}) {
  Match imageMatchers =
      cssBackgroundImageGroupRegex.firstMatch(imageElement?.outerHtml ?? '');
  String imageUrl;

  if (imageMatchers != null && imageMatchers.groupCount >= 1) {
    imageUrl = imageMatchers.group(1);
  } else {
    return defaultImageSrc;
  }

  return normalizeImageUrl(imageUrl, defaultImageSrc: defaultImageSrc);
}

///imageUrl may be something like  '//lain.bgm.tv/pic/user/m/000/1/2/3.jpg' without protocol
///If input is not a valid image url, i.e. it doesn't
///start with '//', or it doesn't contains image extension type '.jpg'/'.png'
///(Bangumi solely uses these types to store image
/// for performance reason we only check these types)
///[defaultImageSrc] will be returned
String normalizeImageUrl(String imageUrl,
    {defaultImageSrc = 'https://bgm.tv/img/no_icon_subject.png',
    checkImageExtensionType = true}) {
  if (checkImageExtensionType) {
    if (!validBangumiImageTypeRegex.hasMatch(imageUrl)) {
      return defaultImageSrc;
    }
  }

  if (imageUrl != null &&
      imageUrl.length >= 2 &&
      imageUrl.substring(0, 2) == '//') {
    return 'https:' + imageUrl;
  }

  return defaultImageSrc;
}

///convert url such as '/person/1' to '$host/person/1'
String relativeUrlToAbsolute(String relativeUrl,
    {String host = 'https://bgm.tv'}) {
  return '$host${relativeUrl ?? ""}';
}

/// parse href id of a element
/// If [digitOnly] is set to true, only href Id that ends with pure digits will
/// be captured. Otherwise, any href id that ends up with words(`\w+` in regex)
/// will be captured
String parseHrefId(Element element, {bool digitOnly = false}) {
  if (element == null) {
    return null;
  }

  String hrefId = element.attributes['href']?.trim();
  if (hrefId == null) {
    return null;
  }

  if (digitOnly) {
    return endsWithDigitRegex.firstMatch(hrefId)?.group(0);
  }

  return endsWithWordsRegex.firstMatch(hrefId)?.group(0);
}

String parseFeedId(Element element) {
  String id = element?.attributes['id']?.trim();
  if (id == null) {
    return null;
  }

  return endsWithDigitRegex.firstMatch(id)?.group(0);
}

/// extract first int from a string
int extractFirstIntGroup(String rawString, {defaultValue = 0}) {
  if (rawString == null) return defaultValue;

  Match intMatcher = atLeastOneDigitRegex.firstMatch(rawString);

  if (intMatcher != null) {
    int parsedInt = int.parse(intMatcher.group(0));
    return parsedInt;
  }

  return defaultValue;
}

String imageSrcOrFallback(Element imageElement,
    {fallbackImageSrc = 'https://bgm.tv/img/no_icon_subject.png'}) {
  if (imageElement == null) return null;
  String imageUrl = imageElement.attributes['src'];

  ///maybe because of https://blog.cloudflare.com/mirage2-solving-mobile-speed/ ?
  imageUrl ??= imageElement.attributes['data-cfsrc'];

  return normalizeImageUrl(imageUrl, defaultImageSrc: fallbackImageSrc);
}

Optional<String> getFirstTextNodeContent(NodeList nodeList,
    {trimExtraChars = true}) {
  for (var node in nodeList) {
    if (node.nodeType == Node.TEXT_NODE) {
      if (trimExtraChars) {
        return Optional.of(node.text.replaceAll(RegExp(r'\s+|、|等|：|:'), ''));
      }

      return Optional.of(node.text);
    }
  }

  return Optional.absent();
}

/// trimExtraChars will remove all extra chars, mergeExtraWhiteSpace will merge
/// multiple white space into one
/// mergeExtraWhiteSpace will be skipped if trimExtraChars is set to true
/// (maybe using a enum to indicate trim level)
Optional<String> getMergedTextNodeContent(NodeList nodeList,
    {trimExtraChars = true, mergeExtraWhiteSpace = false}) {
  String mergedText = '';
  for (var node in nodeList) {
    if (node.nodeType == Node.TEXT_NODE) {
      mergedText += node.text;
    }
  }

  if (trimExtraChars) {
    mergedText = mergedText.replaceAll(RegExp(r'\s+|、|等|：'), '');
  }

  if (!trimExtraChars && mergeExtraWhiteSpace) {
    mergedText = mergedText.replaceAll(atLeastOneSpaceRegex, ' ');
  }

  mergedText = mergedText.replaceAll(endsOrStartsWithSpaceRegex, '');

  return isEmpty(mergedText) ? Optional.absent() : Optional.of(mergedText);
}

double parseSubjectScore(Element element) {
  final Element starsInfoElement =
      element.querySelector('.starsinfo,.starstop');

  if (starsInfoElement == null) {
    return null;
  }

  Match scoreMatcher = scoreRegex.firstMatch(starsInfoElement.className);

  if (scoreMatcher?.groupCount == 1) {
    int parsedScore = int.parse(scoreMatcher.group(1));
    if (parsedScore > 0 && parsedScore <= 10) {
      return parsedScore.toDouble();
    }

    return null;
  }

  return null;
}

FeedMetaInfo updateUserAction(
  Element singleTimelineContent,
  FeedMetaInfo userInfo,
) {
  assert(singleTimelineContent != null);
  assert(userInfo != null);

  Optional<String> maybeActionName =
      getMergedTextNodeContent(singleTimelineContent.nodes);

  userInfo = userInfo.rebuild((b) =>
      b..actionName = maybeActionName.isEmpty ? '' : maybeActionName.value);

  return userInfo;
}

final RegExp dummyTimeInfoRegex = RegExp(r'@|\.');

/// Parses a bangumi time string into an absolute [DateTime] object
/// bangumi might represents time in three format
/// 1. English relative time, 1s ago
/// 2. Chinese relative time, 1小时前
/// 3. Timestamp 2017-10-16 17:23
/// If [stripDummyInfo] is set to true(by default it's true), this method will
/// try to strip some possible dummy info first
/// If [rawTime] is invalid, null will be returned
DateTime parseBangumiTime(String rawTime, {stripDummyInfo = true}) {
  if (rawTime == null) {
    return null;
  }

  if (stripDummyInfo) {
    rawTime = rawTime.replaceAll(dummyTimeInfoRegex, '').trim();
  }

  if (rawTime.contains('ago')) {
    return parseEnglishRelativeTime(rawTime);
  }

  if (rawTime.contains('前')) {
    return parseChineseRelativeTime(rawTime);
  }

  return parseDateTime(rawTime);
}

/// Parses time in format like `2019-4-8 02:12` and returns [DateTime]
/// Bangumi typically displays timestamp in GMT+8(Beijing time)
/// Hence +0800 is default time
/// TODO: bangumi allows user to select timezone, find a easy way to read user
/// timeline and parse time accordingly.
DateTime parseDateTime(
  String rawTime, {
  timeZoneShift = '+0800',
}) {
  if (rawTime == null) {
    return null;
  }

  rawTime = rawTime.replaceAllMapped(unnormalizedDateMatcher, (Match m) {
    if (m.groupCount == 0) {
      return '';
    }

    return '-0${m.group(1)}';
  });

  rawTime += timeZoneShift;

  return DateTime.tryParse(rawTime);
}

/// Parses english relative time that's in format `1h 1m ago` and returns
///// absoluteTime in [DateTime]
/// Note: some time unit might not be displayed, i.e. bangumi displays
/// `1d 1h ago` where minutes are not displayed
/// returns null if [rawRelativeTime] cannot be parsed at all
/// Examples:
/// 0s ago / 3m ago / 1h 35m ago / 1d 20h ago
/// Different from [parseChineseRelativeTime],It SEEMS like bangumi only uses
/// this format to display time up to x days ago,  so years are not parsed
/// for performance reason
DateTime parseEnglishRelativeTime(
  String rawRelativeTime,
) {
  if (rawRelativeTime == null) {
    return null;
  }

  final int days = tryParseInt(
      firstCapturedStringOrNull(daysRegexEn, rawRelativeTime),
      defaultValue: null);
  final int hours = tryParseInt(
      firstCapturedStringOrNull(hoursRegexEn, rawRelativeTime),
      defaultValue: null);
  final int minutes = tryParseInt(
      firstCapturedStringOrNull(minutesRegexEn, rawRelativeTime),
      defaultValue: null);
  final int seconds = tryParseInt(
      firstCapturedStringOrNull(secondsRegexEn, rawRelativeTime),
      defaultValue: null);

  if (days == null && hours == null && minutes == null && seconds == null) {
    return null;
  }

  Duration duration = Duration(
      days: days ?? 0,
      hours: hours ?? 0,
      minutes: minutes ?? 0,
      seconds: seconds ?? 0);

  DateTime absoluteTime = DateTime.now().subtract(duration);

  return absoluteTime;
}

/// Parses Chinese relative time that's in format `1小时30分钟前` and returns
/// absoluteTime in [DateTime]
/// Note: some time unit might not be displayed, i.e. bangumi displays
/// `1小时30分钟前` where `天` are not displayed
/// returns null if [rawRelativeTime] cannot be parsed at all
/// Examples:
/// 1秒前 / 29分16秒前 / 12小时1分钟前  / 15天1小时前 / 11月1天前 / 1年前 / 1年3月前
/// Different from [parseEnglishRelativeTime], it SEEMS like Bangumi uses this
/// format to display time up to years / months ago
DateTime parseChineseRelativeTime(String rawRelativeTime) {
  if (rawRelativeTime == null) {
    return null;
  }

  final int years = tryParseInt(
      firstCapturedStringOrNull(yearsRegexZhHans, rawRelativeTime),
      defaultValue: null);
  final int months = tryParseInt(
      firstCapturedStringOrNull(monthsRegexZhHans, rawRelativeTime),
      defaultValue: null);
  final int days = tryParseInt(
      firstCapturedStringOrNull(daysRegexZhHans, rawRelativeTime),
      defaultValue: null);
  final int hours = tryParseInt(
      firstCapturedStringOrNull(hoursRegexZhHans, rawRelativeTime),
      defaultValue: null);
  final int minutes = tryParseInt(
      firstCapturedStringOrNull(minutesRegexZhHans, rawRelativeTime),
      defaultValue: null);
  final int seconds = tryParseInt(
      firstCapturedStringOrNull(secondsRegexZhHans, rawRelativeTime),
      defaultValue: null);

  if (years == null &&
      months == null &&
      days == null &&
      minutes == null &&
      hours == null &&
      seconds == null) {
    return null;
  }

  /// Roughly estimates total days, there will be a margin of error but we should
  /// be fine
  int totalDays = (years ?? 0) * 365 + (months ?? 0) * 30 + (days ?? 0);
  Duration duration = Duration(
      days: totalDays ?? 0,
      hours: hours ?? 0,
      minutes: minutes ?? 0,
      seconds: seconds ?? 0);

  DateTime absoluteTime = DateTime.now().subtract(duration);

  return absoluteTime;
}

/// Returns the element if it's non-null, or an dummy empty div if it's null.
Element elementOrEmptyDiv(Element element) {
  if (element == null) {
    return Element.tag('div');
  }

  return element;
}

/// Returns the next node sibling of current element, or null if there is no such
/// node.
Node nextNodeSibling(Element element) {
  if (element == null || element.parentNode == null) return null;
  var siblings = element.parentNode.nodes;
  for (int i = siblings.indexOf(element) + 1; i < siblings.length; i++) {
    var s = siblings[i];
    if (s is Node) return s;
  }
  return null;
}

String attributesValueOrNull(Element element, String attributeName) {
  if (element == null) {
    return null;
  }

  return element.attributes[attributeName];
}

String toCssRGBAString(Color color) {
  // [Color] stores color in argb color, it needs to be converted to rgba(used
  // by css).
  final argb = color.value.toRadixString(16).padLeft(8, '0');
  final rgba = '${argb.substring(2)}${argb.substring(0, 2)}';
  return '#$rgba';
}
