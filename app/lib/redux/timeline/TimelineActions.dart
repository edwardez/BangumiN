import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/timeline/common/FeedLoadType.dart';
import 'package:munin/models/bangumi/timeline/common/GetTimelineRequest.dart';
import 'package:munin/providers/bangumi/timeline/parser/TimelineParser.dart';

class LoadTimelineRequest {
  final Completer completer;
  final BuildContext context;
  final GetTimelineRequest getTimelineRequest;
  final FeedLoadType feedLoadType;

  LoadTimelineRequest(
      {@required this.context,
      @required this.feedLoadType,
        @required this.getTimelineRequest,
      Completer completer})
      : this.completer = completer ?? Completer();
}

class LoadTimelineSuccess {
  final GetTimelineRequest getTimelineRequest;
  final GetTimelineParsedResponse parsedResponse;

  LoadTimelineSuccess({
    @required this.parsedResponse,
    @required this.getTimelineRequest,
  });
}
