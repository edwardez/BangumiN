import 'package:built_collection/built_collection.dart';
import 'package:munin/models/bangumi/timeline/common/FeedLoadType.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';
import 'package:munin/providers/bangumi/timeline/BangumiTimelineService.dart';
import 'package:munin/providers/bangumi/timeline/parser/TimelineParser.dart';
import 'package:munin/redux/timeline/TimelineActions.dart';
import 'package:munin/redux/timeline/TimelineState.dart';
import 'package:redux/redux.dart';

final timelineReducers = combineReducers<TimelineState>([
  TypedReducer<TimelineState, LoadTimelineFeedSuccess>(
      loadTimelineFeedSuccessReducer),
]);

TimelineState loadTimelineFeedSuccessReducer(TimelineState timelineState,
    LoadTimelineFeedSuccess loadTimelineFeedSuccess) {
  FetchFeedsResult result = loadTimelineFeedSuccess.fetchFeedsResult;
  List<TimelineFeed> feeds = result.feeds;

  if (result.feedLoadType == FeedLoadType.Initial) {
    bool hasReachedEnd = false;

    /// Even the initial load returns less than [feedsPerPage] feeds
    /// Which means there are no more feeds to load
    if (feeds.length <= feedsPerPage) {
      hasReachedEnd = true;
    }

    return timelineState.rebuild((b) => b
      ..feedChunks.update((b) => b
        ..first.replace(BuiltList<TimelineFeed>(feeds))
        ..disableLoadingMore = false
        ..hasReachedEnd = hasReachedEnd));
  }

  if (result.feedLoadType == FeedLoadType.Newer) {
    BuiltList<TimelineFeed> currentFeedsInFirstChunk =
        timelineState.feedChunks.first;

    if (result.truncateFeedsInStore) {
      return timelineState.rebuild((b) => b
        ..feedChunks.update((b) => b
          ..first.replace(BuiltList<TimelineFeed>(feeds))
          ..disableLoadingMore = false
          ..hasReachedEnd = false));

      /// clean up feeds
    } else {
      currentFeedsInFirstChunk =
          currentFeedsInFirstChunk.rebuild((b) => b..insertAll(0, feeds));
      return timelineState.rebuild((b) => b
        ..feedChunks.update((b) =>
        b
          ..first.replace(currentFeedsInFirstChunk)
          ..disableLoadingMore = false
          ..hasReachedEnd = false));
    }
  }

  if (result.feedLoadType == FeedLoadType.Older) {
    bool disableLoadingMore = false;
    if (feeds.isEmpty) {
      disableLoadingMore = true;
    }

    BuiltList<TimelineFeed> currentFeedsInFirstChunk =
        timelineState.feedChunks.first;

    currentFeedsInFirstChunk =
        currentFeedsInFirstChunk.rebuild((b) => b..addAll(feeds));
    return timelineState.rebuild((b) => b
      ..feedChunks.update((b) =>
      b
        ..first.replace(currentFeedsInFirstChunk)
        ..disableLoadingMore = disableLoadingMore));
  }

  return timelineState;
}
