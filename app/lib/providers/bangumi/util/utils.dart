import 'package:html/dom.dart' show Element, Node, NodeList;
import 'package:munin/models/Bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:quiver/core.dart';
import 'package:quiver/strings.dart';

String aHrefContains(String keyword) {
  return 'a[href*="$keyword"]';
}

/// retrieve image url from background-image css property
/// Note: instead of accessing this property directly, [Element.outerHtml] of the
///  element is used
String imageUrlFromBackgroundImage(Element imageElement,
    {defaultImageSrc = 'https://bgm.tv/img/no_icon_subject.png'}) {
  Match imageMatchers = RegExp(r"""background-image:url\('([^']*)'\)""")
      .firstMatch(imageElement?.outerHtml ?? '');
  String imageUrl;

  if (imageMatchers != null && imageMatchers.groupCount >= 1) {
    imageUrl = imageMatchers.group(1);
  } else {
    return defaultImageSrc;
  }

  return normalizeImageUrl(imageUrl,
      defaultImageSrc: defaultImageSrc);
}

///imageUrl may be something like  '//lain.bgm.tv/pic/user/m/000/1/2/3.jpg' without protocol
String normalizeImageUrl(String imageUrl,
    {defaultImageSrc = 'https://bgm.tv/img/no_icon_subject.png'}) {
  if (imageUrl != null && imageUrl.substring(0, 2) == '//')
    return 'https:' + imageUrl;

  return defaultImageSrc;
}

///convert url such as '/person/1' to '$host/person/1'
String relativeUrlToAbsolute(String relativeUrl,
    {String host = 'https://bgm.tv'}) {
  return '$host${relativeUrl ?? ""}';
}

String parseHrefId(Element element) {
  if (element == null) {
    return null;
  }

  String hrefId = element.attributes['href']?.trim();
  if (hrefId == null) {
    return null;
  }

  return RegExp(r'\w+$')
      .firstMatch(hrefId)
      ?.group(0);
}

String parseFeedId(Element element) {
  String id = element?.attributes['id']?.trim();
  if (id == null) {
    return null;
  }

  return RegExp(r'\d+$')
      .firstMatch(id)
      ?.group(0);
}

/// extract first int from a string
int extractFirstInt(String rawString, {defaultValue = 0}) {
  if (rawString == null) return defaultValue;

  Match intMatcher =
  RegExp(r'\d+').firstMatch(rawString);

  if (intMatcher != null) {
    int parsedInt = int.parse(intMatcher.group(0));
    return parsedInt;
  }

  return defaultValue;
}

String imageSrcOrNull(Element imageElement,
    {defaultImageSrc = 'https://bgm.tv/img/no_icon_subject.png'}) {
  if (imageElement == null) return null;
  String imageUrl = imageElement.attributes['src'];

  ///maybe because of https://blog.cloudflare.com/mirage2-solving-mobile-speed/ ?
  imageUrl ??= imageElement.attributes['data-cfsrc'];

  return normalizeImageUrl(imageUrl,
      defaultImageSrc: defaultImageSrc);
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
    mergedText = mergedText.replaceAll(RegExp(r'\s+'), ' ');
  }

  mergedText = mergedText.replaceAll(RegExp(r'^\s+|\s+$'), '');

  return isEmpty(mergedText) ? Optional.absent() : Optional.of(mergedText);
}

double parseSubjectScore(Element element) {
  final Element starsInfoElement = element.querySelector('.starsinfo');

  if (starsInfoElement == null) {
    return null;
  }

  Match scoreMatcher =
      RegExp(r'sstars(\d+)').firstMatch(starsInfoElement.className);

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
    Element singleTimelineContent, FeedMetaInfo userInfo) {
  assert(singleTimelineContent != null);
  assert(userInfo != null);

  Optional<String> maybeActionName =
      getMergedTextNodeContent(singleTimelineContent.nodes);

  userInfo = userInfo.rebuild((b) =>
      b..actionName = maybeActionName.isEmpty ? '' : maybeActionName.value);

  return userInfo;
}
