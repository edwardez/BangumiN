import 'dart:collection';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parseFragment;
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/providers/bangumi/util/regex.dart';
import 'package:munin/providers/bangumi/util/utils.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:munin/shared/utils/misc/constants.dart';

class ImportBlockedUserParser {
  BuiltMap<String, MutedUser> process(String rawHtml) {
    DocumentFragment document = parseFragment(rawHtml);

    LinkedHashMap<String, MutedUser> users = LinkedHashMap<String, MutedUser>();
    Element blockedUsersTableElement;

    for (Element possibleBlockedUsersTableElement
        in document.querySelectorAll('form')) {
      if (possibleBlockedUsersTableElement.text.contains('绝交')) {
        blockedUsersTableElement = possibleBlockedUsersTableElement;
      }
    }

    if (blockedUsersTableElement == null) {
      debugPrint('Cannot find blocked user table.');
      return BuiltMap<String, MutedUser>(users);
    }

    List<Element> blockedUserRows =
        blockedUsersTableElement.querySelectorAll('tr');

    ///
    for (Element row in blockedUserRows) {
      Element userElement = row.querySelector('a[href*="/user/"]');
      Element unblockElement =
          row.querySelector('a[href*="/settings/privacy?ignore_reset"]');

      /// `tr` itself contains rows that are not blocked user row so above two
      /// selectors might return null, skipping them here
      if (userElement == null || unblockElement == null) {
        continue;
      }

      String username = parseHrefId(userElement);

      /// Unblock element is a a link contains a href like
      /// `/settings/privacy?ignore_reset=12345&gh=xx02md1`
      /// integer after ignore_reset is the user id
      int userId = tryParseInt(
          firstCapturedStringOrNull(
              blockedUserIdGroupRegex, unblockElement.attributes['href']),
          defaultValue: null);

      if (username == null || userId == null) {
        debugPrint(
            'Skipping block user element because username or id is null. Element: ${userElement.outerHtml}');
        continue;
      }

      String nickname = userElement.text.trim();

      users[username] = MutedUser((b) => b
        ..username = username
        ..userId = userId
        ..nickname = nickname
        ..userAvatar.replace(BangumiImage.useSameImageUrlForAll(
            bangumiAnonymousUserMediumAvatar))
        ..isImportedFromBangumi = true);
    }

    return BuiltMap<String, MutedUser>(users);
  }
}
