import 'package:built_collection/built_collection.dart';
import 'package:munin/models/bangumi/timeline/common/FeedLoadType.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';
import 'package:munin/redux/timeline/TimelineActions.dart';
import 'package:munin/redux/timeline/TimelineState.dart';
import 'package:redux/redux.dart';

final timelineReducers = combineReducers<TimelineState>([
  TypedReducer<TimelineState, LoadTimelineFeedSuccess>(
      loadTimelineFeedSuccessReducer),
]);

TimelineState loadTimelineFeedSuccessReducer(TimelineState timelineState,
    LoadTimelineFeedSuccess loadTimelineFeedSuccess) {
  List<TimelineFeed> newFeeds = loadTimelineFeedSuccess.feeds;

  /// do nothing if nothing needs to be updated
  if (newFeeds == null || newFeeds.isEmpty) {
    return timelineState;
  }

  if (loadTimelineFeedSuccess.feedLoadType == FeedLoadType.Initial) {
    return timelineState.rebuild((b) => b
      ..feedChunks.update((b) => b
        ..first.replace(BuiltList<TimelineFeed>(newFeeds))
        ..second.replace(BuiltList<TimelineFeed>())));
  }

  if (loadTimelineFeedSuccess.feedLoadType == FeedLoadType.Newer &&
      newFeeds.isNotEmpty) {
    bool hasGap = loadTimelineFeedSuccess.hasGap ?? false;
    BuiltList<TimelineFeed> currentFeedsInFirstChunk =
        timelineState.feedChunks.first;

    if (hasGap) {
      return timelineState.rebuild((b) => b
        ..feedChunks.update((b) => b
          ..first.replace(BuiltList<TimelineFeed>(newFeeds))
          ..second.replace(BuiltList<TimelineFeed>())));

      /// clean up feeds
    } else {
      currentFeedsInFirstChunk =
          currentFeedsInFirstChunk.rebuild((b) => b..insertAll(0, newFeeds));
      return timelineState.rebuild((b) => b
        ..feedChunks.update((b) => b..first.replace(currentFeedsInFirstChunk)));
    }
  }

  if (loadTimelineFeedSuccess.feedLoadType == FeedLoadType.Older &&
      newFeeds.isNotEmpty) {
    BuiltList<TimelineFeed> currentFeedsInFirstChunk =
        timelineState.feedChunks.first;

    currentFeedsInFirstChunk =
        currentFeedsInFirstChunk.rebuild((b) => b..addAll(newFeeds));
    return timelineState.rebuild((b) => b
      ..feedChunks.update((b) => b..first.replace(currentFeedsInFirstChunk)));
  }

  return timelineState;
}
