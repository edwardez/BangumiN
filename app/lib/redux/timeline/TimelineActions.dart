import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/timeline/common/FeedLoadType.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';

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
  final List<TimelineFeed> feeds;
  final FeedLoadType feedLoadType;

  final bool hasGap;

  LoadTimelineFeedSuccess(
      {@required this.feeds, @required this.feedLoadType, this.hasGap});
}
