import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/timeline/PublicMessageNormal.dart';
import 'package:munin/models/bangumi/timeline/common/FeedLoadType.dart';
import 'package:munin/models/bangumi/timeline/common/GetTimelineRequest.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';
import 'package:munin/models/bangumi/timeline/message/FullPublicMessage.dart';
import 'package:munin/providers/bangumi/timeline/parser/TimelineParser.dart';

class GetTimelineRequestAction {
  final Completer completer;
  final BuildContext context;
  final GetTimelineRequest getTimelineRequest;
  final FeedLoadType feedLoadType;

  GetTimelineRequestAction(
      {@required this.context,
      @required this.feedLoadType,
      @required this.getTimelineRequest,
      Completer completer})
      : this.completer = completer ?? Completer();
}

class GetTimelineSuccessAction {
  final GetTimelineRequest getTimelineRequest;
  final GetTimelineParsedResponse parsedResponse;

  GetTimelineSuccessAction({
    @required this.parsedResponse,
    @required this.getTimelineRequest,
  });
}

class DeleteTimelineAction {
  final GetTimelineRequest getTimelineRequest;
  final TimelineFeed feed;

  final Completer completer;

  DeleteTimelineAction({
    @required this.feed,
    @required this.getTimelineRequest,
    Completer completer,
  }) : this.completer = completer ?? Completer();
}

class DeleteTimelineSuccessAction {
  final GetTimelineRequest getTimelineRequest;
  final TimelineFeed feed;

  /// user name of the current app user
  final String appUsername;

  DeleteTimelineSuccessAction(
      {@required this.feed,
      @required this.getTimelineRequest,
      @required this.appUsername});
}

class CreateMainPublicMessageRequestAction {
  final BuildContext context;
  final String message;

  final Completer completer;

  CreateMainPublicMessageRequestAction({
    @required this.context,
    @required this.message,
    Completer completer,
  }) : this.completer = completer ?? Completer();
}

class GetFullPublicMessageRequestAction {
  final PublicMessageNormal mainMessage;

  final Completer completer;

  GetFullPublicMessageRequestAction({
    @required this.mainMessage,
    Completer completer,
  }) : this.completer = completer ?? Completer();
}

class GetFullPublicMessageSuccessAction {
  final FullPublicMessage fullPublicMessage;

  const GetFullPublicMessageSuccessAction({@required this.fullPublicMessage});
}

class CreatePublicMessageReplyRequestAction {
  final PublicMessageNormal mainMessage;

  final String reply;

  final Completer completer;

  CreatePublicMessageReplyRequestAction({
    @required this.mainMessage,
    @required this.reply,
    Completer completer,
  }) : this.completer = completer ?? Completer();
}
