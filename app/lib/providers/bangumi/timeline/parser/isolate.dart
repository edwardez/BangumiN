import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:munin/models/bangumi/BangumiUserSmall.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/models/bangumi/timeline/common/FeedLoadType.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineSource.dart';
import 'package:munin/providers/bangumi/timeline/parser/TimelineParser.dart';

GetTimelineParsedResponse processTimelineFeeds(
    ParseTimelineFeedsMessage message) {
  return TimelineParser(mutedUsers: message.mutedUsers).processTimelineFeeds(
    message.html,
    feedLoadType: message.feedLoadType,
    upperFeedId: message.upperFeedId,
    lowerFeedId: message.lowerFeedId,
    timelineSource: message.timelineSource,
    userInfo: message.userInfo,
  );
}

class ParseTimelineFeedsMessage {
  final String html;

  final TimelineSource timelineSource;

  final BuiltMap<String, MutedUser> mutedUsers;

  final BangumiUserSmall userInfo;

  final FeedLoadType feedLoadType;
  final int upperFeedId;
  final int lowerFeedId;

  ParseTimelineFeedsMessage(
    this.html, {
    @required this.timelineSource,
    @required this.userInfo,
    @required this.feedLoadType,
    @required this.mutedUsers,
    this.upperFeedId,
    this.lowerFeedId,
  });
}
