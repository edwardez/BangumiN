import 'package:built_collection/built_collection.dart';
import 'package:munin/models/bangumi/timeline/common/FeedLoadType.dart';
import 'package:munin/models/bangumi/timeline/common/FetchTimelineRequest.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';
import 'package:munin/providers/bangumi/timeline/BangumiTimelineService.dart';
import 'package:munin/providers/bangumi/timeline/parser/TimelineParser.dart';
import 'package:munin/redux/timeline/FeedChunks.dart';
import 'package:munin/redux/timeline/TimelineActions.dart';
import 'package:munin/redux/timeline/TimelineState.dart';
import 'package:redux/redux.dart';

final timelineReducers = combineReducers<TimelineState>([
  TypedReducer<TimelineState, LoadTimelineSuccess>(
      loadTimelineFeedSuccessReducer),
]);

TimelineState loadTimelineFeedSuccessReducer(TimelineState timelineState,
    LoadTimelineSuccess loadTimelineFeedSuccess) {
  FetchTimelineRequest fetchTimelineRequest =
      loadTimelineFeedSuccess.fetchTimelineRequest;
  FeedChunks feedChunksInStore =
      timelineState.timeline[fetchTimelineRequest] ?? FeedChunks();
  FetchFeedsResult result = loadTimelineFeedSuccess.fetchFeedsResult;

  List<TimelineFeed> feedsResponse = result.feeds;

  if (result.feedLoadType == FeedLoadType.Initial) {
    bool hasReachedEnd = false;
    bool disableLoadingMore = false;

    /// Even the initial load returns less than [feedsPerPage] feeds
    /// Which means there are no more feeds to load
    if (feedsResponse.length < feedsPerPage) {
      hasReachedEnd = true;
      disableLoadingMore = true;
    }

    return timelineState.rebuild((b) => b
      ..timeline.addAll({
        fetchTimelineRequest: feedChunksInStore.rebuild((b) =>
        b
          ..first.replace(BuiltList<TimelineFeed>(feedsResponse))
          ..disableLoadingMore = disableLoadingMore
          ..hasReachedEnd = hasReachedEnd)
      }));
  }

  if (result.feedLoadType == FeedLoadType.Newer) {
    BuiltList<TimelineFeed> currentFeedsInFirstChunk = feedChunksInStore.first;

    if (result.truncateFeedsInStore) {
      /// clean up feeds
      return timelineState.rebuild((b) => b
        ..timeline.addAll({
          fetchTimelineRequest: feedChunksInStore.rebuild((b) =>
          b
            ..first.replace(BuiltList<TimelineFeed>(feedsResponse))
            ..disableLoadingMore = false
            ..hasReachedEnd = false)
        }));
    } else {
      BuiltList<TimelineFeed> updatedFeeds =
      currentFeedsInFirstChunk.rebuild((b) => b..insertAll(0, feedsResponse));
      return timelineState.rebuild((b) => b
        ..timeline.addAll({
          fetchTimelineRequest: feedChunksInStore.rebuild((b) =>
          b
            ..first.replace(updatedFeeds)
            ..disableLoadingMore = false
            ..hasReachedEnd = false)
        }));
    }
  }

  if (result.feedLoadType == FeedLoadType.Older) {
    bool disableLoadingMore = feedsResponse.isEmpty;

    BuiltList<TimelineFeed> currentFeedsInFirstChunk = feedChunksInStore.first;

    BuiltList<TimelineFeed> updatedFeeds =
    currentFeedsInFirstChunk.rebuild((b) => b..addAll(feedsResponse));

    return timelineState.rebuild((b) => b
      ..timeline.addAll({
        fetchTimelineRequest: feedChunksInStore.rebuild((b) =>
        b
          ..first.replace(updatedFeeds)
          ..disableLoadingMore = disableLoadingMore)
      }));
  }

  return timelineState;
}
