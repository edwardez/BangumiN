import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/timeline/common/FeedLoadType.dart';
import 'package:munin/providers/bangumi/timeline/parser/TimelineParser.dart';

class LoadTimelineFeed {
  final Completer completer;
  final BuildContext context;
  final FeedLoadType feedLoadType;

  LoadTimelineFeed(
      {@required this.context,
      @required this.feedLoadType,
      Completer completer})
      : this.completer = completer ?? new Completer();
}

class LoadTimelineFeedSuccess {
  final FetchFeedsResult fetchFeedsResult;

  LoadTimelineFeedSuccess({@required this.fetchFeedsResult});
}
