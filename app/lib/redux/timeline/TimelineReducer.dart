import 'package:built_collection/built_collection.dart';
import 'package:munin/models/bangumi/timeline/common/FeedLoadType.dart';
import 'package:munin/models/bangumi/timeline/common/GetTimelineRequest.dart';
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
  GetTimelineRequest getTimelineRequest =
      loadTimelineFeedSuccess.getTimelineRequest;
  FeedChunks feedChunksInStore =
      timelineState.timeline[getTimelineRequest] ?? FeedChunks();
  GetTimelineParsedResponse result = loadTimelineFeedSuccess.parsedResponse;

  List<TimelineFeed> unfilteredFeedsResponse = result.feeds;

  List<TimelineFeed> filteredFeedsResponse =
  unfilteredFeedsResponse.where((feed) => !feed.isFromMutedUser).toList();

  if (result.feedLoadType == FeedLoadType.Initial) {
    bool hasReachedEnd = false;
    bool disableLoadingMore = false;

    /// Even the initial load returns less than [feedsPerPage] feeds
    /// Which means there are no more feeds to load
    if (unfilteredFeedsResponse.length < feedsPerPage) {
      hasReachedEnd = true;
      disableLoadingMore = true;
    }

    return timelineState.rebuild((b) => b
      ..timeline.addAll({
        getTimelineRequest: feedChunksInStore.rebuild((b) =>
        b
          ..first.replace(BuiltList<TimelineFeed>(filteredFeedsResponse))
          ..unfilteredFirst.replace(
              BuiltList<TimelineFeed>(unfilteredFeedsResponse))
          ..disableLoadingMore = disableLoadingMore
          ..hasReachedEnd = hasReachedEnd
          ..lastFetchedTime = result.fetchedTime)
      }));
  }

  if (result.feedLoadType == FeedLoadType.Newer) {
    if (result.truncateFeedsInStore) {
      /// clean up feeds
      return timelineState.rebuild((b) => b
        ..timeline.addAll({
          getTimelineRequest: feedChunksInStore.rebuild((b) =>
          b
            ..first.replace(BuiltList<TimelineFeed>(filteredFeedsResponse))
            ..unfilteredFirst.replace(
                BuiltList<TimelineFeed>(unfilteredFeedsResponse))
            ..disableLoadingMore = false
            ..hasReachedEnd = false
            ..lastFetchedTime = result.fetchedTime)
        }));
    } else {
      BuiltList<TimelineFeed> unfilteredUpdatedFeeds = feedChunksInStore
          .unfilteredFirst
          .rebuild((b) => b..insertAll(0, unfilteredFeedsResponse));

      BuiltList<TimelineFeed> updatedFilteredFeeds = feedChunksInStore.first
          .rebuild((b) => b..insertAll(0, filteredFeedsResponse));

      return timelineState.rebuild((b) => b
        ..timeline.addAll({
          getTimelineRequest: feedChunksInStore.rebuild((b) =>
          b
            ..first.replace(updatedFilteredFeeds)
            ..unfilteredFirst.replace(unfilteredUpdatedFeeds)
            ..disableLoadingMore = false
            ..hasReachedEnd = false
            ..lastFetchedTime = result.fetchedTime)
        }));
    }
  }

  if (result.feedLoadType == FeedLoadType.Older) {
    bool disableLoadingMore = unfilteredFeedsResponse.isEmpty;

    BuiltList<TimelineFeed> unfilteredUpdatedFeeds =
    feedChunksInStore.unfilteredFirst.rebuild((b) =>
    b
      ..addAll(unfilteredFeedsResponse));

    BuiltList<TimelineFeed> updatedFilteredFeeds =
    feedChunksInStore.first.rebuild((b) =>
    b
      ..addAll(filteredFeedsResponse));

    return timelineState.rebuild((b) => b
      ..timeline.addAll({
        getTimelineRequest: feedChunksInStore.rebuild((b) =>
        b
          ..first.replace(updatedFilteredFeeds)
          ..unfilteredFirst.replace(unfilteredUpdatedFeeds)
          ..disableLoadingMore = disableLoadingMore
          ..lastFetchedTime = result.fetchedTime)
      }));
  }

  return timelineState;
}
