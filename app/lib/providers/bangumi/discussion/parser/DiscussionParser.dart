import 'package:html/dom.dart';
import 'package:html/parser.dart' show parseFragment;
import 'package:munin/models/bangumi/common/Images.dart';
import 'package:munin/models/bangumi/discussion/DiscussionItem.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/providers/bangumi/util/regex.dart';
import 'package:munin/providers/bangumi/util/utils.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:quiver/strings.dart';

class DiscussionParser {
  static const Map<String, BangumiContent> elementIdToContentType = {
    'prsn': BangumiContent.Person,
    'crt': BangumiContent.Character,
    'ep': BangumiContent.Episode,
    'subject': BangumiContent.SubjectTopic,
    'group': BangumiContent.GroupTopic,
  };

  static const Map<BangumiContent, ImageType> contentTypeToImageType = {
    BangumiContent.Person: ImageType.MonoAvatar,
    BangumiContent.Character: ImageType.MonoAvatar,
    BangumiContent.Episode: ImageType.SubjectCover,
    BangumiContent.SubjectTopic: ImageType.SubjectCover,
    BangumiContent.GroupTopic: ImageType.UserAvatar,
  };

  static final elementTypeRegex = RegExp(r'_(\w+)_');

  /// bangumi uses id to identify each discussion element and we can thus use
  /// this info to guess [BangumiContent]
  /// i.e. item_ep_1, [BangumiContent] is [BangumiContent.Episode], id is 1
  /// If we cannot find a valid type, null will be returned
  BangumiContent _guessContentType(String elementId) {
    String capturedString =
        firstCapturedStringOrNull(elementTypeRegex, elementId);
    return elementIdToContentType[capturedString];
  }

  DiscussionItem parseDiscussionItem(Element discussionItemElement,
      {BangumiContent contentType}) {
    final defaultTitle = '-';

    String elementIdAttr = discussionItemElement.id;

    int itemId = tryParseInt(
        firstCapturedStringOrNull(
            endsWithAlphanumericGroupRegex, elementIdAttr),
        defaultValue: null);

    if (contentType == null) {
      contentType = _guessContentType(elementIdAttr);
    }

    /// If contentType is null even after guessing, or elementId is null,
    /// It's meaningless to continue so we just return null
    if (contentType == null || itemId == null) {
      return null;
    }

    String imageUrlSmall = imageUrlFromBackgroundImage(discussionItemElement);
    ImageType imageType = contentTypeToImageType[contentType];
    Images images;
    if (imageType == null) {
      images = Images.useSameImageUrlForAll(imageUrlSmall);
    } else {
      images = Images.fromImageUrl(imageUrlSmall, ImageSize.Small, imageType);
    }

    String title = discussionItemElement.querySelector('.title')?.text;

    if (isEmpty(title)) {
      title = defaultTitle;
    }

    String subtitle = discussionItemElement.querySelector('.row > a')?.text;

    if (contentType.isMono) {
      subtitle = contentType.chineseName;
    } else if (isEmpty(subtitle)) {
      subtitle = defaultTitle;
    }

    String replyCountStr =
        discussionItemElement.querySelector('.grey')?.text ?? '0';
    int replyCount = tryParseInt(
        firstCapturedStringOrNull(atLeastOneDigitGroupRegex, replyCountStr));

    Element timeElement = discussionItemElement.querySelector('.time');
    DateTime absoluteTime = parseBangumiTime(timeElement?.text);
    return DiscussionItem((b) => b
      ..id = itemId
      ..bangumiContent = contentType
      ..images.replace(images)
      ..title = title
      ..subTitle = subtitle
      ..updatedAt = absoluteTime?.millisecondsSinceEpoch
      ..replyCount = replyCount);
  }

  List<DiscussionItem> process(String rawHtml,
      {BangumiContent bangumiContent}) {
    DocumentFragment document = parseFragment(rawHtml);
    List<DiscussionItem> discussionItems = [];
    List<Element> discussionItemElements =
        document.querySelectorAll('#eden_tpc_list li');
    for (Element element in discussionItemElements) {
      DiscussionItem discussionItem = parseDiscussionItem(element);
      if (discussionItem != null) {
        discussionItems.add(discussionItem);
      }
    }

    return discussionItems;
  }
}
