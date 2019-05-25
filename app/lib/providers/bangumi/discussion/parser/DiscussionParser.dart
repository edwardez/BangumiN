import 'package:html/dom.dart';
import 'package:html/parser.dart' show parseFragment;
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/discussion/DiscussionItem.dart';
import 'package:munin/models/bangumi/discussion/GeneralDiscussionItem.dart';
import 'package:munin/models/bangumi/discussion/GroupDiscussionPost.dart';
import 'package:munin/models/bangumi/setting/mute/MuteSetting.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/providers/bangumi/util/regex.dart';
import 'package:munin/providers/bangumi/util/utils.dart';
import 'package:munin/shared/exceptions/exceptions.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:quiver/core.dart';
import 'package:quiver/strings.dart';

class DiscussionParser {
  static const Map<String, BangumiContent> elementIdToContentType = {
    'prsn': BangumiContent.Person,
    'crt': BangumiContent.Character,
    'ep': BangumiContent.Episode,
    'subject': BangumiContent.SubjectTopic,
    'group': BangumiContent.GroupTopic,
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

  Optional<DiscussionItem> parseDiscussionItem(Element discussionItemElement,
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
      return Optional.absent();
    }

    String imageUrlSmall = imageUrlFromBackgroundImage(discussionItemElement);
    ImageType imageType = contentType.imageType;
    BangumiImage image;
    if (imageType == null) {
      image = BangumiImage.useSameImageUrlForAll(imageUrlSmall);
    } else {
      image = BangumiImage.fromImageUrl(
          imageUrlSmall, ImageSize.Unknown, imageType);
    }

    String title = discussionItemElement.querySelector('.title')?.text;

    if (isEmpty(title)) {
      title = defaultTitle;
    }

    String subtitle;

    if (contentType.isMono) {
      subtitle = contentType.chineseName;
    } else {
      subtitle = discussionItemElement
          .querySelector('.row > a')
          ?.text;
      if (isEmpty(subtitle)) {
        subtitle = defaultTitle;
      }
    }

    String replyCountStr =
        discussionItemElement.querySelector('.grey')?.text ?? '0';
    int replyCount = tryParseInt(
        firstCapturedStringOrNull(atLeastOneDigitGroupRegex, replyCountStr));

    Element timeElement = discussionItemElement.querySelector('.time');
    DateTime absoluteTime = parseBangumiTime(timeElement?.text);

    if (contentType != BangumiContent.GroupTopic) {
      return Optional.of(GeneralDiscussionItem((b) =>
      b
        ..id = itemId
        ..bangumiContent = contentType
        ..image.replace(image)
        ..title = title
        ..subTitle = subtitle
        ..updatedAt = absoluteTime?.millisecondsSinceEpoch
        ..replyCount = replyCount));
    } else {
      int originalPosterUserId = tryParseInt(
          firstCapturedStringOrNull(userIdInAvatarGroupRegex, image.small),
          defaultValue: null);

      Element groupElement =
      discussionItemElement.querySelector('.row a[href*="/group/"]');
      String postedGroupId = parseHrefId(groupElement);

      return Optional.of(GroupDiscussionPost((b) =>
      b
        ..id = itemId
        ..bangumiContent = contentType
        ..image.replace(image)
        ..title = title
        ..subTitle = subtitle
        ..updatedAt = absoluteTime?.millisecondsSinceEpoch
        ..replyCount = replyCount
        ..postedGroupId = postedGroupId
        ..originalPosterUserId = originalPosterUserId));
    }
  }

  bool isMutedItem(DiscussionItem item, MuteSetting muteSetting) {
    if (item is! GroupDiscussionPost) {
      return false;
    }
    GroupDiscussionPost post = item;

    /// 1. Checks whether user muted the group
    bool isMutedGroup = muteSetting.mutedGroups.containsKey(post.postedGroupId);
    if (isMutedGroup) {
      return true;
    }

    /// 2. Checks whether user muted user with default icon
    bool muteOPWithDefaultIcon;

    if (muteSetting.muteOriginalPosterWithDefaultIcon &&
        item.image.small.contains('icon.jpg')) {
      muteOPWithDefaultIcon = true;
    } else {
      muteOPWithDefaultIcon = false;
    }

    if (muteOPWithDefaultIcon) {
      return true;
    }

    /// 2. Checks whether user muted op
    bool isMutedOp = false;
    for (MutedUser mutedUser in muteSetting.mutedUsers.values) {
      if (mutedUser.userId == post.originalPosterUserId) {
        isMutedOp = true;
        break;
      }
    }

    if (isMutedOp) {
      return true;
    }

    return false;
  }

  List<DiscussionItem> process(String rawHtml,
      {@required MuteSetting muteSetting, BangumiContent bangumiContent}) {
    DocumentFragment document = parseFragment(rawHtml);
    List<DiscussionItem> discussionItems = [];
    List<Element> discussionItemElements =
        document.querySelectorAll('#eden_tpc_list li');
    for (Element element in discussionItemElements) {
      Optional<DiscussionItem> maybeDiscussionItem =
      parseDiscussionItem(element);
      if (maybeDiscussionItem.isPresent &&
          !isMutedItem(maybeDiscussionItem.value, muteSetting)) {
        discussionItems.add(maybeDiscussionItem.value);
      }
    }

    if (discussionItems.isEmpty) {
      throw BangumiResponseIncomprehensibleException('从Bangumi返回的讨论列表为空');
    }

    return discussionItems;
  }
}
