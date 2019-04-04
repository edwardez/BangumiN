import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/common/FeedLoadType.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';
import 'package:munin/providers/bangumi/timeline/BangumiTimelineService.dart';
import 'package:munin/providers/bangumi/timeline/parser/TimelineParser.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/timeline/TimelineActions.dart';
import 'package:munin/shared/exceptions/exceptions.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:redux/redux.dart';
import 'package:tuple/tuple.dart';

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
        /// bangumi returns 10 feeds each time, this cannot be changed currently
        int feedPerPage = 10;

        /// by default, always loads the first page
        int nextPageNum = 1;

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

        if (action.feedLoadType == FeedLoadType.Older) {
          /// newer feeds always loads the next page after the last
          nextPageNum = 1 +
              store.state.timelineState.feedChunks.first.length ~/ feedPerPage;

          int firstChunkMinIdOrNull =
              store.state.timelineState?.feedChunks?.firstChunkMinIdOrNull;

          /// if firstChunkMinIdOrNull is null, most likely it's a
          /// [UnknownTimelineActivity] so feedId cannot be filled in
          /// we just load all new feeds
          /// TODO: clean up all newer feeds in this case?
          lowerFeedId = firstChunkMinIdOrNull ?? IntegerHelper.MAX_VALUE;
        }

        if (action.feedLoadType == FeedLoadType.Gap) {
          throw UnimplementedError(
              ' FeedLoadType.Gap is currently not implemented');
        }

        var feedsHtml = await bangumiTimelineService.getTimeline(
            nextPageNum: nextPageNum);

        TimelineParser timelineParser = TimelineParser();

        Tuple2<List<TimelineFeed>, bool> processedFeeds =
            timelineParser.process(feedsHtml.data,
                feedLoadType: action.feedLoadType,
                upperFeedId: upperFeedId,
                lowerFeedId: lowerFeedId);

        debugPrint('Recevied ${processedFeeds.item1.length} feeds');

        store.dispatch(LoadTimelineFeedSuccess(
            feeds: processedFeeds.item1,
            hasGap: processedFeeds.item2,
            feedLoadType: action.feedLoadType));
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
