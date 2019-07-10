import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/BangumiUserSmall.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/models/bangumi/timeline/common/FeedLoadType.dart';
import 'package:munin/models/bangumi/timeline/common/GetTimelineRequest.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineCategoryFilter.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineSource.dart';
import 'package:munin/providers/bangumi/timeline/BangumiTimelineService.dart';
import 'package:munin/providers/bangumi/timeline/parser/TimelineParser.dart';
import 'package:munin/providers/bangumi/user/BangumiUserService.dart';
import 'package:munin/redux/app/AppActions.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/timeline/FeedChunks.dart';
import 'package:munin/redux/timeline/TimelineActions.dart';
import 'package:munin/shared/exceptions/utils.dart';
import 'package:munin/shared/utils/collections/common.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:munin/shared/utils/misc/async.dart';
import 'package:munin/widgets/shared/common/SnackBar.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

List<Epic<AppState>> createTimelineEpics(
    BangumiTimelineService bangumiTimelineService,
    BangumiUserService bangumiUserService) {
  final getTimelineEpic =
      _createGetTimelineEpics(bangumiTimelineService, bangumiUserService);

  final deleteTimelineEpic = _createDeleteTimelineEpic(bangumiTimelineService);

  final createTimelineMessageEpic =
  _createCreateTimelineMessageEpic(bangumiTimelineService);

  final getFullPublicMessageEpic =
  _createGetFullPublicMessageEpic(bangumiTimelineService);

  final createPublicMessageReplyRequestEpic =
  _createCreatePublicMessageReplyRequestEpic(bangumiTimelineService);

  return [
    getTimelineEpic,
    deleteTimelineEpic,
    createTimelineMessageEpic,
    getFullPublicMessageEpic,
    createPublicMessageReplyRequestEpic,
  ];
}

Stream<dynamic> _getTimelineEpic(
    BangumiTimelineService bangumiTimelineService,
    BangumiUserService bangumiUserService,
    GetTimelineRequestAction action,
    EpicStore<AppState> store) async* {
  try {
    assert(action.feedLoadType == FeedLoadType.Initial ||
        action.feedLoadType == FeedLoadType.Newer ||
        action.feedLoadType == FeedLoadType.Older);

    BuiltMap<String, MutedUser> mutedUsers =
        store.state.settingState.muteSetting.mutedUsers;

    int upperFeedId = IntegerHelper.MAX_VALUE;
    int lowerFeedId = IntegerHelper.MIN_VALUE;
    int nextPageNum;

    FeedChunks feedChunks;
    BangumiUserSmall userInfo;

    if (action.getTimelineRequest.timelineSource ==
        TimelineSource.UserProfile) {
      assert(action.getTimelineRequest.username != null);

      feedChunks =
          store.state.timelineState.timeline[action.getTimelineRequest] ??
              FeedChunks();
      userInfo = store.state.userState
          .profiles[action.getTimelineRequest.username]?.basicInfo;
      assert(userInfo != null);

      if (userInfo == null) {
        userInfo = await bangumiUserService
            .getUserBasicInfo(action.getTimelineRequest.username);
      }
    } else if (action.getTimelineRequest.timelineSource ==
        TimelineSource.OnlyFriends) {
      feedChunks =
          store.state.timelineState.timeline[action.getTimelineRequest] ??
              FeedChunks();
    } else {
      throw UnimplementedError('尚未支持读取这种时间线');
    }

    /// For newer feeds, we don't need to set [nextPageNum]
    if (action.feedLoadType == FeedLoadType.Newer) {
      ///if firstChunkMaxIdOrNull is null, most likely it's a [UnknownTimelineActivity]
      /// so feedId cannot be filled in we just load all new feeds
      /// TODO: clean up all older feeds in this case?
      upperFeedId =
          firstOrNullInIterable<TimelineFeed>(feedChunks.unfilteredFeeds)
                  ?.user
                  ?.feedId ??
              IntegerHelper.MIN_VALUE;
    }

    if (action.feedLoadType == FeedLoadType.Older) {
      /// if firstChunkMinIdOrNull is null, most likely it's a
      /// [UnknownTimelineActivity] so feedId cannot be filled in
      /// we just load all new feeds
      /// TODO: clean up all newer feeds in this case?
      lowerFeedId =
          firstOrNullInIterable<TimelineFeed>(feedChunks.unfilteredFeeds)
                  ?.user
                  ?.feedId ??
              IntegerHelper.MAX_VALUE;

      int tentativeNextPageNum =
          1 + feedChunks.unfilteredFeeds.length ~/ feedsPerPage;

      /// To ensure all feeds are delivered, we need to consider all scenarios
      /// (assume every time we fetch 10 feeds)
      /// 1. if current feed length can be divided by [feedsPerPage], just get the next
      /// page
      /// 2. if current feed length cannot be divided by [feedsPerPage]:
      /// we always fetch feed on
      /// 2.1 There are no un-fetched new feeds. i.e. user has
      /// feed 1 - feed 11. This can happen if user fetches 10 feeds at first,
      /// then tries to request new feeds which returns 1 feed
      /// If this is true, next fetch for page 2 should return 9 valid feeds
      /// We just return these 9 valid feeds
      /// 2.2 There are some un-fetched new feeds, and it's < 10. i.e.
      /// [un-fetched feed1-feed5], feed 6 - feed 20,
      /// This can happen if user fetches 10 feeds(feed6-feed17) at first, then doesn't fetch for a
      /// long time.
      /// If user then tries to request older feeds on page 2, only 2 feeds will be
      /// returned(feed18-19). Now user has 14 feeds
      /// If this is true, next fetch for page 2 should return 0 valid feeds
      /// Then we set nextPageNum to page 3
      /// 2.3 un-fetched new feeds are >10, very tricky to handle this scenario
      /// due to limitation of Bangumi. We just repeat logic in 2.1/2.2 for now.
      /// One more thing to consider is in 2.1, if current feeds are near next ~10
      /// like 19. We will only receive 1 valid feeds every time. But this situation
      /// is very rare(we might improve this logic if it happens frequently).
      /// tl;dr: if current feed length cannot be divided by [feedsPerPage], fetch
      /// the next possible page num first, if that returns 0 feed, then fetch
      /// the page after next possible page num
      if (feedChunks.unfilteredFeeds.length % feedsPerPage == 0) {
        nextPageNum = tentativeNextPageNum;
      } else {
        GetTimelineParsedResponse fetchFeedsResult =
            await bangumiTimelineService.getTimeline(
                request: action.getTimelineRequest,
                nextPageNum: tentativeNextPageNum,
                feedLoadType: action.feedLoadType,
                lowerFeedId: lowerFeedId,
                upperFeedId: upperFeedId,
                mutedUsers: mutedUsers,
                userInfo: userInfo);
        if (fetchFeedsResult.feeds.length == 0) {
          nextPageNum = tentativeNextPageNum + 1;
        } else {
          action.completer.complete();
          yield GetTimelineSuccessAction(
              getTimelineRequest: action.getTimelineRequest,
              parsedResponse: fetchFeedsResult);
          return;
        }
      }

      /// For older feeds, [nextPageNum] must be present
      assert(nextPageNum != null);
    }

    assert(action.feedLoadType != FeedLoadType.Gap,
        '${action.feedLoadType} is currently not implemented');

    GetTimelineParsedResponse fetchFeedsResult =
        await bangumiTimelineService.getTimeline(
            request: action.getTimelineRequest,
            nextPageNum: nextPageNum,
            feedLoadType: action.feedLoadType,
            lowerFeedId: lowerFeedId,
            upperFeedId: upperFeedId,
            mutedUsers: mutedUsers,
            userInfo: userInfo);

    debugPrint(
        'Feeds number before loading: ${feedChunks.unfilteredFeeds.length}.'
        ' Recevied ${fetchFeedsResult.feeds.length} new feeds.');

    yield GetTimelineSuccessAction(
        getTimelineRequest: action.getTimelineRequest,
        parsedResponse: fetchFeedsResult);
    action.completer.complete();
  } catch (error, stack) {
    action.completer.completeError(error, stack);

    yield HandleErrorAction(
      context: action.context,
      error: error,
      stack: stack,
      showErrorMessageSnackBar: false,
    );

    /// For loading older feeds, error messages are directly shown on item list
    if (action.feedLoadType == FeedLoadType.Initial ||
        action.feedLoadType == FeedLoadType.Newer) {
      showTextOnSnackBar(
          action.context, error.toString());
    }
  } finally {
    completeDanglingCompleter(action.completer);
  }
}

Epic<AppState> _createGetTimelineEpics(
    BangumiTimelineService bangumiTimelineService,
    BangumiUserService bangumiUserService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<GetTimelineRequestAction>())
        .switchMap((action) => _getTimelineEpic(
            bangumiTimelineService, bangumiUserService, action, store));
  };
}

Stream<dynamic> _deleteTimeline(BangumiTimelineService bangumiTimelineService,
    DeleteTimelineAction action, EpicStore<AppState> store) async* {
  try {
    await bangumiTimelineService.deleteTimeline(action.feed.user.feedId);
    yield DeleteTimelineSuccessAction(
        feed: action.feed,
        getTimelineRequest: action.getTimelineRequest,
        appUsername: store.state.currentAuthenticatedUserBasicInfo.username);
    action.completer.complete();
  } catch (error, stack) {
    reportError(error, stack: stack);
    action.completer.completeError(error);
  } finally {
    completeDanglingCompleter(action.completer);
  }
}

Epic<AppState> _createDeleteTimelineEpic(
    BangumiTimelineService bangumiTimelineService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<DeleteTimelineAction>())
        .concatMap(
            (action) => _deleteTimeline(bangumiTimelineService, action, store));
  };
}

Stream<dynamic> _submitTimelineMessage(
    BangumiTimelineService bangumiTimelineService,
    CreateMainPublicMessageRequestAction action,
    EpicStore<AppState> store) async* {
  try {
    await bangumiTimelineService.submitTimelineMessage(action.message);

    Navigator.of(action.context).pop();

    // Refreshes main profile timeline
    GetTimelineRequest request = GetTimelineRequest((b) => b
      ..timelineSource = TimelineSource.UserProfile
      ..username = store.state.currentAuthenticatedUserBasicInfo.username
      ..timelineCategoryFilter = TimelineCategoryFilter.AllFeeds);

    Completer completer = Completer();
    yield GetTimelineRequestAction(
        getTimelineRequest: request,
        context: action.context,
        feedLoadType: FeedLoadType.Newer,
        completer: completer);

    await completer.future;

    action.completer.complete();

    // Once refreshing main profile timeline complete, refreshes PublicMessage timeline, too
    request = request.rebuild((b) =>
        b..timelineCategoryFilter = TimelineCategoryFilter.PublicMessage);
    yield GetTimelineRequestAction(
      getTimelineRequest: request,
      context: action.context,
      feedLoadType: FeedLoadType.Newer,
    );
  } catch (error, stack) {
    action.completer.completeError(error, stack);

    yield HandleErrorAction(
      context: action.context,
      error: error,
      stack: stack,
    );
  } finally {
    completeDanglingCompleter(action.completer);
  }
}

Epic<AppState> _createCreateTimelineMessageEpic(
    BangumiTimelineService bangumiTimelineService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<CreateMainPublicMessageRequestAction>())
        .concatMap((action) =>
            _submitTimelineMessage(bangumiTimelineService, action, store));
  };
}

Stream<dynamic> _getFullPublicMessageEpic(
    BangumiTimelineService bangumiTimelineService,
    GetFullPublicMessageRequestAction action,
    EpicStore<AppState> store) async* {
  try {
    final fullMessage = await bangumiTimelineService.getFullPublicMessage(
        action.mainMessage, store.state.settingState.muteSetting.mutedUsers);

    yield GetFullPublicMessageSuccessAction(fullPublicMessage: fullMessage);
    action.completer.complete();
  } catch (error, stack) {
    action.completer.completeError(error, stack);
  } finally {
    completeDanglingCompleter(action.completer);
  }
}

Epic<AppState> _createGetFullPublicMessageEpic(
    BangumiTimelineService bangumiTimelineService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<GetFullPublicMessageRequestAction>())
        .concatMap((action) =>
        _getFullPublicMessageEpic(bangumiTimelineService, action, store));
  };
}

Stream<dynamic> _createPublicMessageReplyRequestEpic(
    BangumiTimelineService bangumiTimelineService,
    CreatePublicMessageReplyRequestAction action,
    EpicStore<AppState> store) async* {
  try {
    await bangumiTimelineService.createPublicMessageReply(
      action.reply,
      action.mainMessage.user.feedId,
    );

    yield GetFullPublicMessageRequestAction(mainMessage: action.mainMessage);

    action.completer.complete();
  } catch (error, stack) {
    action.completer.completeError(error, stack);
  } finally {
    completeDanglingCompleter(action.completer);
  }
}

Epic<AppState> _createCreatePublicMessageReplyRequestEpic(
    BangumiTimelineService bangumiTimelineService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<CreatePublicMessageReplyRequestAction>())
        .concatMap((action) =>
        _createPublicMessageReplyRequestEpic(
            bangumiTimelineService, action, store));
  };
}
