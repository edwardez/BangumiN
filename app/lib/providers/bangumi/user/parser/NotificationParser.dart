import 'package:built_collection/built_collection.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:munin/models/bangumi/user/notification/BaseNotificationItem.dart';
import 'package:munin/models/bangumi/user/notification/FriendshipRequestNotificationItem.dart';
import 'package:munin/models/bangumi/user/notification/GeneralNotificationItem.dart';
import 'package:munin/providers/bangumi/util/parser/ParseBangumiUser.dart';
import 'package:munin/providers/bangumi/util/utils.dart';
import 'package:munin/shared/utils/common.dart';

class NotificationParser {
  static final connectButtonUserIdExtractor = RegExp(r'\/connect\/(\d+)');
  static final avatarUserIdExtractor = RegExp(r'(\d+)\.jpg');

  NotificationParser();

  BuiltList<BaseNotificationItem> _parseNotificationItems(
      DocumentFragment document) {
    final notificationElements =
        document.querySelectorAll('#comment_list > div');

    final List<BaseNotificationItem> items = [];
    for (final element in notificationElements) {
      var initiator = parseBangumiUserBasic(element);

      final bodyContentElement = element.querySelector('.reply_content');
      final itemId = parseEndsWithDigitId(element);

      final isFriendshipRequest =
          element.querySelector('.frd_connect') != null ||
              (bodyContentElement.text.trim() == '请求与你成为好友');

      // Attach user id to [initiator]. If userId cannot be found, don't treat
      // this item as [isFriendshipRequest].
      if (isFriendshipRequest) {
        int userId;
        final connectButton = element.querySelector('a[href*="/connect/"]');
        if (connectButton != null) {
          userId = tryParseInt(
              firstCapturedStringOrNull(connectButtonUserIdExtractor,
                  connectButton.attributes['href']),
              defaultValue: null);
        }

        if (userId != null) {
          initiator = initiator.rebuild((b) => b.id = userId);

          items.add(FriendshipRequestNotificationItem((b) => b
            ..initiator.replace(initiator)
            ..bodyContentHtml = bodyContentElement.outerHtml
            ..id = itemId));
        } else {
          items.add(GeneralNotificationItem((b) => b
            ..initiator.replace(initiator)
            ..bodyContentHtml = bodyContentElement.outerHtml
            ..id = itemId));
        }
      } else {
        items.add(GeneralNotificationItem((b) => b
          ..initiator.replace(initiator)
          ..bodyContentHtml = bodyContentElement.outerHtml
          ..id = itemId));
      }
    }

    return BuiltList<BaseNotificationItem>.of(items);
  }

  BuiltList<BaseNotificationItem> process(String rawHtml) {
    final document = parseFragment(rawHtml);

    return _parseNotificationItems(document);
  }
}
