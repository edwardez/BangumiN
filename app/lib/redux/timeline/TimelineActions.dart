import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/timeline/common/FeedLoadType.dart';
import 'package:munin/models/bangumi/timeline/common/FetchTimelineRequest.dart';
import 'package:munin/providers/bangumi/timeline/parser/TimelineParser.dart';

class LoadTimelineRequest {
  final Completer completer;
  final BuildContext context;
  final FetchTimelineRequest fetchTimelineRequest;
  final FeedLoadType feedLoadType;

  LoadTimelineRequest(
      {@required this.context,
      @required this.feedLoadType,
        @required this.fetchTimelineRequest,
      Completer completer})
      : this.completer = completer ?? Completer();
}

class LoadTimelineSuccess {
  final FetchTimelineRequest fetchTimelineRequest;
  final FetchFeedsResult fetchFeedsResult;

  LoadTimelineSuccess({
    @required this.fetchFeedsResult,
    @required this.fetchTimelineRequest,
  });
}
