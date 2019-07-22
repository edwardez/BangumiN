import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/models/bangumi/user/collection/full/ListUserCollectionsRequest.dart';
import 'package:munin/models/bangumi/user/notification/BaseNotificationItem.dart';
import 'package:munin/providers/bangumi/user/parser/NotificationParser.dart';
import 'package:munin/providers/bangumi/user/parser/UserCollectionsListParser.dart';
import 'package:munin/providers/bangumi/user/parser/UserParser.dart';

UserProfile processUserProfile(String rawHtml) {
  return UserParser().processUserProfile(rawHtml);
}

ParsedCollections processUserCollectionsList(ParseUserCollectionsListMessage message) {
  return UserCollectionsListParser(request: message.request)
      .processUserCollectionsList(
    message.rawHtml,
    requestedPageNumber: message.requestedPageNumber,
    filterTag: message.filterTag,
  );
}

BuiltList<BaseNotificationItem> processListNotification(
    ParseListNotificationMessage message) {
  return NotificationParser().process(message.rawHtml);
}

class ParseListNotificationMessage {
  final String rawHtml;

  ParseListNotificationMessage(this.rawHtml,);
}

class ParseUserCollectionsListMessage {
  final String rawHtml;
  final int requestedPageNumber;
  final ListUserCollectionsRequest request;
  final String filterTag;

  ParseUserCollectionsListMessage(this.rawHtml, {
    @required this.requestedPageNumber,
    @required this.request,
    this.filterTag,
  });
}
