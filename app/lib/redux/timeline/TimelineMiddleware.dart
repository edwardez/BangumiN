import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/common/FeedLoadType.dart';
import 'package:munin/providers/bangumi/timeline/BangumiTimelineService.dart';
import 'package:munin/providers/bangumi/timeline/parser/TimelineParser.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/timeline/TimelineActions.dart';
import 'package:munin/shared/exceptions/exceptions.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:redux/redux.dart';


List<Middleware<AppState>> createTimelineMiddleware(
    BangumiTimelineService bangumiTimelineService) {
  final loadTimelineFeed = _createLoadTimelineFeed(bangumiTimelineService);

  return [
    TypedMiddleware<AppState, LoadTimelineFeed>(loadTimelineFeed),
  ];
}

Middleware<AppState> _createLoadTimelineFeed(
    BangumiTimelineService bangumiTimelineService) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    try {
      if (action is LoadTimelineFeed) {
        int upperFeedId = IntegerHelper.MAX_VALUE;
        int lowerFeedId = IntegerHelper.MIN_VALUE;

        if (action.feedLoadType == FeedLoadType.Newer) {
          int firstChunkMaxIdOrNull =
              store.state.timelineState?.feedChunks?.firstChunkMaxIdOrNull;

          ///if firstChunkMaxIdOrNull is null, most likely it's a [UnknownTimelineActivity]
          /// so feedId cannot be filled in we just load all new feeds
          /// TODO: clean up all older feeds in this case?
          upperFeedId = firstChunkMaxIdOrNull ?? IntegerHelper.MIN_VALUE;
        }

        int nextPageNum;
        if (action.feedLoadType == FeedLoadType.Older) {
          /// newer feeds always loads the next page after the last
          nextPageNum = initialPageNum +
              (store.state.timelineState.feedChunks.first.length / feedsPerPage)
                  .ceil();

          int firstChunkMinIdOrNull =
              store.state.timelineState?.feedChunks?.firstChunkMinIdOrNull;

          /// if firstChunkMinIdOrNull is null, most likely it's a
          /// [UnknownTimelineActivity] so feedId cannot be filled in
          /// we just load all new feeds
          /// TODO: clean up all newer feeds in this case?
          lowerFeedId = firstChunkMinIdOrNull ?? IntegerHelper.MAX_VALUE;
        } else {
          /// otherwise, by default always loads the first page
          nextPageNum = initialPageNum;
        }

        if (action.feedLoadType == FeedLoadType.Gap) {
          throw UnimplementedError(
              '${action.feedLoadType} is currently not implemented');
        }

        FetchFeedsResult fetchFeedsResult =
        await bangumiTimelineService.getTimeline(
            nextPageNum: nextPageNum,
                feedLoadType: action.feedLoadType,
            lowerFeedId: lowerFeedId,
            upperFeedId: upperFeedId);

        debugPrint('Recevied ${fetchFeedsResult.feeds.length} feeds');

        store.dispatch(
            LoadTimelineFeedSuccess(fetchFeedsResult: fetchFeedsResult));
      }
    } on AuthenticationExpiredException catch (authenticationExpiredException) {
      Scaffold.of(action.context).showSnackBar(
          SnackBar(content: Text(authenticationExpiredException.message)));
    } catch (error, stack) {
      print(error.toString());
      print(stack);
      Scaffold.of(action.context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    } finally {
      action.completer.complete();
    }

    next(action);
  };
}
