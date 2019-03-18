import 'package:html/dom.dart' show Element, Node, NodeList;
import 'package:munin/models/Bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:quiver/core.dart';
import 'package:quiver/strings.dart';

String aHrefContains(String keyword) {
  return 'a[href*="$keyword"]';
}

///imageUrl may be something like  '//lain.bgm.tv/pic/user/m/000/1/2/3.jpg' without protocol
String normalizeImageUrl(String imageUrl) {
  if (imageUrl != null && imageUrl[0] == '/') return 'https:' + imageUrl;

  return imageUrl;
}

String parseHrefId(Element element) {
  return RegExp(r'\w+$')
      .firstMatch(element?.attributes['href']?.trim())
      ?.group(0);
}

String parseFeedId(Element element) {
  return RegExp(r'\d+$')
      .firstMatch(element?.attributes['id']?.trim())
      ?.group(0);
}

String imageSrcOrNull(
  Element imageElement,
) {
  if (imageElement == null) return null;

  return normalizeImageUrl(imageElement?.attributes['src']);
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
