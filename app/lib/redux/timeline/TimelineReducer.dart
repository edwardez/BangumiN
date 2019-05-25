import 'package:built_collection/built_collection.dart';
import 'package:munin/models/bangumi/timeline/common/FeedLoadType.dart';
import 'package:munin/models/bangumi/timeline/common/GetTimelineRequest.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineCategoryFilter.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineSource.dart';
import 'package:munin/providers/bangumi/timeline/BangumiTimelineService.dart';
import 'package:munin/providers/bangumi/timeline/parser/TimelineParser.dart';
import 'package:munin/redux/timeline/FeedChunks.dart';
import 'package:munin/redux/timeline/TimelineActions.dart';
import 'package:munin/redux/timeline/TimelineState.dart';
import 'package:redux/redux.dart';

final timelineReducers = combineReducers<TimelineState>([
  TypedReducer<TimelineState, GetTimelineSuccessAction>(
      loadTimelineFeedSuccessReducer),
  TypedReducer<TimelineState, DeleteTimelineSuccessAction>(
      deleteTimelineFeedSuccessReducer),
]);

TimelineState loadTimelineFeedSuccessReducer(TimelineState timelineState,
    GetTimelineSuccessAction action) {
  GetTimelineRequest getTimelineRequest = action.getTimelineRequest;
  FeedChunks feedChunksInStore =
      timelineState.timeline[getTimelineRequest] ?? FeedChunks();
  GetTimelineParsedResponse result = action.parsedResponse;

  List<TimelineFeed> unfilteredFeedsResponse = result.feeds;

  List<TimelineFeed> filteredFeedsResponse;


  if (action.getTimelineRequest.timelineSource == TimelineSource.UserProfile) {
    /// Copies unfilteredFeedsResponse to filteredFeedsResponse as-is if feeds
    /// are intended to be displayed on user profile page
    /// This does mean data is redundant but it actually makes the code cleaner
    /// since there's no need to add separate logic for profile page feeds in the
    /// following code
    filteredFeedsResponse = unfilteredFeedsResponse.toList();
  } else {
    filteredFeedsResponse =
        unfilteredFeedsResponse.where((feed) => !feed.isFromMutedUser).toList();
  }

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
          ..filteredFeeds.replace(
              BuiltList<TimelineFeed>(filteredFeedsResponse))
          ..unfilteredFeeds
              .replace(BuiltList<TimelineFeed>(unfilteredFeedsResponse))
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
            ..filteredFeeds.replace(
                BuiltList<TimelineFeed>(filteredFeedsResponse))
            ..unfilteredFeeds
                .replace(BuiltList<TimelineFeed>(unfilteredFeedsResponse))
            ..disableLoadingMore = false
            ..hasReachedEnd = false
            ..lastFetchedTime = result.fetchedTime)
        }));
    } else {
      BuiltList<TimelineFeed> unfilteredUpdatedFeeds = feedChunksInStore
          .unfilteredFeeds
          .rebuild((b) => b..insertAll(0, unfilteredFeedsResponse));

      BuiltList<TimelineFeed> updatedFilteredFeeds = feedChunksInStore
          .filteredFeeds
          .rebuild((b) => b..insertAll(0, filteredFeedsResponse));

      return timelineState.rebuild((b) => b
        ..timeline.addAll({
          getTimelineRequest: feedChunksInStore.rebuild((b) =>
          b
            ..filteredFeeds.replace(updatedFilteredFeeds)
            ..unfilteredFeeds.replace(unfilteredUpdatedFeeds)
            ..disableLoadingMore = false
            ..hasReachedEnd = false
            ..lastFetchedTime = result.fetchedTime)
        }));
    }
  }

  if (result.feedLoadType == FeedLoadType.Older) {
    bool disableLoadingMore = unfilteredFeedsResponse.isEmpty;

    BuiltList<TimelineFeed> unfilteredUpdatedFeeds = feedChunksInStore
        .unfilteredFeeds
        .rebuild((b) => b..addAll(unfilteredFeedsResponse));

    BuiltList<TimelineFeed> updatedFilteredFeeds = feedChunksInStore
        .filteredFeeds
        .rebuild((b) => b..addAll(filteredFeedsResponse));

    return timelineState.rebuild((b) => b
      ..timeline.addAll({
        getTimelineRequest: feedChunksInStore.rebuild((b) =>
        b
          ..filteredFeeds.replace(updatedFilteredFeeds)
          ..unfilteredFeeds.replace(unfilteredUpdatedFeeds)
          ..disableLoadingMore = disableLoadingMore
          ..lastFetchedTime = result.fetchedTime)
      }));
  }

  return timelineState;
}

TimelineState deleteTimelineFeedSuccessReducer(TimelineState timelineState,
    DeleteTimelineSuccessAction action) {
  TimelineState removeFeed(TimelineState localTimelineState,
      GetTimelineRequest request) {
    FeedChunks feedChunks = localTimelineState.timeline[request];
    if (feedChunks == null) {
      return localTimelineState;
    }

    int feedId = action?.feed?.user?.feedId;

    feedChunks = feedChunks.rebuild((b) =>
    b
      ..filteredFeeds.removeWhere((feed) => feed?.user?.feedId == feedId)
      ..unfilteredFeeds.removeWhere((feed) => feed?.user?.feedId == feedId)
    );


    return localTimelineState.rebuild((b) =>
    b
      ..timeline.addAll(
          {
            request: feedChunks
          }
      ));
  }

  var getTimelineRequest = action.getTimelineRequest;

  // Removes feed from home page and profile timeline
  timelineState = removeFeed(timelineState, getTimelineRequest.rebuild((b) =>
  b
    ..timelineSource = TimelineSource.FriendsOnly
    ..username = null
  ));

  timelineState = removeFeed(timelineState, getTimelineRequest.rebuild((b) =>
  b
    ..timelineSource = TimelineSource.UserProfile
    ..username = action.appUsername
  ));

  // Deletes feed from `all feeds` timeline if user deletes feed while under another
  // category.
  if (getTimelineRequest.timelineCategoryFilter !=
      TimelineCategoryFilter.AllFeeds) {
    timelineState = removeFeed(timelineState, getTimelineRequest.rebuild((b) =>
    b
      ..timelineSource = TimelineSource.UserProfile
      ..timelineCategoryFilter = TimelineCategoryFilter.AllFeeds
      ..username = action.appUsername
    ));

    timelineState = removeFeed(timelineState, getTimelineRequest.rebuild((b) =>
    b
      ..timelineSource = TimelineSource.FriendsOnly
      ..timelineCategoryFilter = TimelineCategoryFilter.AllFeeds
      ..username = null
    ));
  } else {
    // Else deleting it from the sub timeline
    timelineState = removeFeed(timelineState, getTimelineRequest.rebuild((b) =>
    b
      ..timelineSource = TimelineSource.UserProfile
      ..timelineCategoryFilter = action.feed.bangumiContent.applicableFeedFilter
      ..username = action.appUsername
    ));

    timelineState = removeFeed(timelineState, getTimelineRequest.rebuild((b) =>
    b
      ..timelineSource = TimelineSource.FriendsOnly
      ..timelineCategoryFilter = action.feed.bangumiContent.applicableFeedFilter
      ..username = null
    ));
  }

  return timelineState;
}

