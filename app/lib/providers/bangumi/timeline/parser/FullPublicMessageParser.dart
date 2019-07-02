import 'package:built_collection/built_collection.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/common/BangumiUserBasic.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/models/bangumi/timeline/PublicMessageNormal.dart';
import 'package:munin/models/bangumi/timeline/message/FullPublicMessage.dart';
import 'package:munin/models/bangumi/timeline/message/PublicMessageReply.dart';
import 'package:munin/providers/bangumi/util/utils.dart';
import 'package:munin/shared/exceptions/exceptions.dart';

class FullPublicMessageParser {
  final BuiltMap<String, MutedUser> mutedUsers;

  const FullPublicMessageParser({@required this.mutedUsers});

  /// Parses [PublicMessageReply], it's ok if some middle element is null
  /// and null pointer exception is thrown as this gives upstream a chance
  /// to know parser failed.
  PublicMessageReply _parsePublicMessageReply(Element replyElement) {
    final replyButton = replyElement.querySelector('.cmt_reply');
    final authorElement = replyButton.nextElementSibling;

    final username = parseHrefId(authorElement);
    final nickname = authorElement?.text;

    /// Removes hidden remove button.
    replyButton.remove();

    const bangumiDefaultSeparator = '-';

    replyElement.querySelectorAll('.tip_j').forEach((element) {
      if (element.text == bangumiDefaultSeparator) {
        element.text = ':';
      }
    });

    final user = BangumiUserBasic((b) => b
      ..username = username
      ..nickname = nickname);

    return PublicMessageReply((b) => b
      ..contentHtml = replyElement.outerHtml
      ..contentText = replyElement.text
      ..author.replace(user));
  }

  FullPublicMessage processReplies(
      String rawHtml, PublicMessageNormal publicMessageNormal) {
    final document = parseFragment(rawHtml);
    if (document.querySelector('.subReply') == null) {
      throw BangumiResponseIncomprehensibleException('无法获取回复数据');
    }

    List<PublicMessageReply> replies = [];

    /// Total number of replies, include muted.
    int totalUnfilteredReplies = 0;

    for (var element in document.querySelectorAll('li.reply_item')) {
      final reply = _parsePublicMessageReply(element);
      totalUnfilteredReplies++;
      if (!mutedUsers.containsKey(reply.author.username)) {
        replies.add(reply);
      }
    }

    /// Updates reply count, if it's different from calculated reply count.
    if (publicMessageNormal.replyCount != totalUnfilteredReplies) {
      publicMessageNormal = publicMessageNormal.rebuild((b) {
        b..replyCount = totalUnfilteredReplies;
      });
    }

    return FullPublicMessage((b) => b
      ..mainMessage.replace(publicMessageNormal)
      ..replies.replace(BuiltList<PublicMessageReply>.of(replies)));
  }
}
