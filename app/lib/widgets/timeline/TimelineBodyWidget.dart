import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/timeline/BlogCreationSingle.dart';
import 'package:munin/models/bangumi/timeline/CollectionUpdateSingle.dart';
import 'package:munin/models/bangumi/timeline/FriendshipCreationSingle.dart';
import 'package:munin/models/bangumi/timeline/GroupJoinSingle.dart';
import 'package:munin/models/bangumi/timeline/IndexFavoriteSingle.dart';
import 'package:munin/models/bangumi/timeline/MonoFavoriteSingle.dart';
import 'package:munin/models/bangumi/timeline/ProgressUpdateEpisodeSingle.dart';
import 'package:munin/models/bangumi/timeline/ProgressUpdateEpisodeUntil.dart';
import 'package:munin/models/bangumi/timeline/PublicMessageNoReply.dart';
import 'package:munin/models/bangumi/timeline/PublicMessageNormal.dart';
import 'package:munin/models/bangumi/timeline/StatusUpdateMultiple.dart';
import 'package:munin/models/bangumi/timeline/UnknownTimelineActivity.dart';
import 'package:munin/models/bangumi/timeline/WikiCreationSingle.dart';
import 'package:munin/models/bangumi/timeline/common/FeedLoadType.dart';
import 'package:munin/models/bangumi/timeline/common/GetTimelineRequest.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/timeline/FeedChunks.dart';
import 'package:munin/redux/timeline/TimelineActions.dart';
import 'package:munin/shared/utils/collections/common.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/widgets/shared/appbar/OneMuninBar.dart';
import 'package:munin/widgets/shared/avatar/CachedCircleAvatar.dart';
import 'package:munin/widgets/shared/refresh/MuninRefresh.dart';
import 'package:munin/widgets/timeline/item/BlogCreationSingleWidget.dart';
import 'package:munin/widgets/timeline/item/CollectionUpdateSingle.dart';
import 'package:munin/widgets/timeline/item/FriendshipCreationSingleWidget.dart';
import 'package:munin/widgets/timeline/item/GroupJoinSingleWidget.dart';
import 'package:munin/widgets/timeline/item/IndexFavoriteSingleWidget.dart';
import 'package:munin/widgets/timeline/item/MonoFavoriteSingle.dart';
import 'package:munin/widgets/timeline/item/ProgressUpdateEpisodeSingleWidget.dart';
import 'package:munin/widgets/timeline/item/ProgressUpdateEpisodeUntilWidget.dart';
import 'package:munin/widgets/timeline/item/PublicMessageNoReplyWidget.dart';
import 'package:munin/widgets/timeline/item/PublicMessageNormalWidget.dart';
import 'package:munin/widgets/timeline/item/StatusUpdateMultipleWidget.dart';
import 'package:munin/widgets/timeline/item/UnknownTimelineActivityWidget.dart';
import 'package:munin/widgets/timeline/item/WikiCreationSingleWidget.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

class TimelineBodyWidget extends StatefulWidget {
  final OneMuninBar oneMuninBar;
  final GetTimelineRequest getTimelineRequest;

  const TimelineBodyWidget(
      {Key key,
      @required this.oneMuninBar,
        @required this.getTimelineRequest})
      : assert(getTimelineRequest != null),
        assert(oneMuninBar != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TimelineBodyWidgetState();
  }
}

class _TimelineBodyWidgetState extends State<TimelineBodyWidget> {
  GlobalKey<MuninRefreshState> _muninRefreshKey =
      GlobalKey<MuninRefreshState>();

  Widget getWidgetByType(timelineItem) {
    if (timelineItem is PublicMessageNoReply) {
      return PublicMessageNoReplyWidget(
        publicMessageNoReply: timelineItem,
      );
    }
    if (timelineItem is PublicMessageNormal) {
      return PublicMessageNormalWidget(
        publicMessageNormal: timelineItem,
      );
    }
    if (timelineItem is BlogCreationSingle) {
      return BlogCreationSingleWidget(
        blogCreationSingle: timelineItem,
      );
    }
    if (timelineItem is CollectionUpdateSingle) {
      return CollectionUpdateSingleWidget(
        collectionUpdateSingle: timelineItem,
      );
    }
    if (timelineItem is FriendshipCreationSingle) {
      return FriendshipCreationSingleWidget(
        friendshipCreationSingle: timelineItem,
      );
    }
    if (timelineItem is GroupJoinSingle) {
      return GroupJoinSingleWidget(
        groupJoinSingle: timelineItem,
      );
    }
    if (timelineItem is IndexFavoriteSingle) {
      return IndexFavoriteSingleWidget(
        indexFavoriteSingle: timelineItem,
      );
    }
    if (timelineItem is MonoFavoriteSingle) {
      return MonoFavoriteSingleWidget(
        monoFavoriteSingle: timelineItem,
      );
    }
    if (timelineItem is ProgressUpdateEpisodeSingle) {
      return ProgressUpdateEpisodeSingleWidget(
        progressUpdateEpisodeSingle: timelineItem,
      );
    }
    if (timelineItem is ProgressUpdateEpisodeUntil) {
      return ProgressUpdateEpisodeUntilWidget(
        progressUpdateEpisodeUntil: timelineItem,
      );
    }
    if (timelineItem is StatusUpdateMultiple) {
      return StatusUpdateMultipleWidget(
        statusUpdateMultiple: timelineItem,
      );
    }
    if (timelineItem is UnknownTimelineActivity) {
      return UnknownTimelineActivityWidget(
        unknownTimelineActivity: timelineItem,
      );
    }
    if (timelineItem is WikiCreationSingle) {
      return WikiCreationSingleWidget(
        wikiCreationSingle: timelineItem,
      );
    }

    return Container();
  }

  IndexedWidgetBuilder _createItemBuilder(_ViewModel viewModel,
      bool hasFilterAllFeeds) {
    if (hasFilterAllFeeds) {
      return (BuildContext context, int index) {
        Semantics(child: Container(), excludeSemantics: true);
      };
    }

    FeedChunks feedChunks = viewModel.feedChunks;
    return (BuildContext context, int index) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if(feedChunks
              .getFeedAt(index)
              ?.user
              ?.username != null)
            CachedCircleAvatar(
              imageUrl: feedChunks.getFeedAt(index)?.user?.avatarImageUrl,
              navigateToUserRouteOnTap: true,
              username: feedChunks
                  .getFeedAt(index)
                  .user
                  .username,
            ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 8),
              child: getWidgetByType(feedChunks.getFeedAt(index)),
            ),
          )
        ],
      );
    };
  }

  /// A widget that will show up if the timeline is empty
  _buildEmptyTimelineWidget() {
    return Column(
      children: <Widget>[
        Text('时间线为空，可能因为：'),
        Text('1. $appOrBangumiHasAnError，下拉可重试'),
        Text('2. 您尚未关注任何已发表动态的用户'),
        FlatButton(
          child: Text(checkWebVersionPrompt),
          onPressed: () {
            return launch(bangumiTimelineUrl, forceSafariVC: true);
          },
        )
      ],
    );
  }

  /// A widget that will show up if the timeline is empty
  _buildNoMoreItemsWidget() {
    return Center(
      child: Text('由于Bangumi的限制，无法加载更多内容'),
    );
  }

  /// Checks whether user has filtered all available feeds by checking if unfiltered
  /// list is not empty while filtered list is empty
  bool userHasFilterAllFeeds(FeedChunks feedChunks) {
    return feedChunks.first.length == 0 &&
        feedChunks.unfilteredFirst.length != 0;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (Store store) =>
          _ViewModel.fromStore(store, widget.getTimelineRequest),
      onInitialBuild: (_ViewModel vm) {
        if (vm.feedChunks.isStale || vm.feedChunks.first.isEmpty) {
          _muninRefreshKey?.currentState?.callOnRefresh();
        }
      },
      builder: (BuildContext context, _ViewModel vm) {
        bool hasFilterAllFeeds = userHasFilterAllFeeds(vm.feedChunks);

        /// Build timeline refresh list
        /// If user has filtered all available feeds, attach an empty `Container()`
        /// to the timeline to ensure load more button will show up
        return MuninRefresh(
            key: _muninRefreshKey,
            onRefresh: () {
              return vm.fetchLatestFeed(context);
            },
            itemBuilder: _createItemBuilder(vm, hasFilterAllFeeds),
            onLoadMore: () {
              return vm.fetchOlderFeed(context);
            },
            refreshWidgetStyle: RefreshWidgetStyle.Adaptive,
            itemCount: hasFilterAllFeeds ? 1 : vm.feedChunks.first.length,
            appBar: widget.oneMuninBar,
            emptyAfterRefreshWidget: _buildEmptyTimelineWidget(),
            noMoreItemsToLoad:
            vm.feedChunks.disableLoadingMore || vm.feedChunks.hasReachedEnd,
            noMoreItemsWidget: _buildNoMoreItemsWidget());
      },
    );
  }
}

class _ViewModel {
  final FeedChunks feedChunks;
  final GetTimelineRequest getTimelineRequest;
  final Future Function(BuildContext context) fetchLatestFeed;
  final Future Function(BuildContext context) fetchOlderFeed;

  factory _ViewModel.fromStore(Store<AppState> store,
      GetTimelineRequest getTimelineRequest) {

    Future _fetchLatestFeed(BuildContext context) {
      FeedChunks feedChunks =
          store.state.timelineState.timeline[getTimelineRequest] ??
              FeedChunks();
      FeedLoadType feedLoadType;
      if (isIterableNullOrEmpty(feedChunks.unfilteredFirst)) {
        feedLoadType = FeedLoadType.Initial;
      } else {
        feedLoadType = FeedLoadType.Newer;
      }

      final action = LoadTimelineRequest(
          context: context,
          feedLoadType: feedLoadType,
          getTimelineRequest: getTimelineRequest);
      store.dispatch(action);

      return action.completer.future;
    }

    Future _fetchOlderFeed(BuildContext context) {
      FeedLoadType feedLoadType = FeedLoadType.Older;

      final action = LoadTimelineRequest(
          context: context,
          feedLoadType: feedLoadType,
          getTimelineRequest: getTimelineRequest);
      store.dispatch(action);

      return action.completer.future;
    }

    return _ViewModel(
      feedChunks: store.state.timelineState.timeline[getTimelineRequest] ??
          FeedChunks(),
      getTimelineRequest: getTimelineRequest,
      fetchLatestFeed: (context) => _fetchLatestFeed(context),
      fetchOlderFeed: (context) => _fetchOlderFeed(context),
    );
  }

  _ViewModel(
      {@required this.feedChunks,
        @required this.getTimelineRequest,
      @required this.fetchLatestFeed,
      @required this.fetchOlderFeed});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          feedChunks == other.feedChunks &&
          getTimelineRequest == other.getTimelineRequest;

  @override
  int get hashCode => hash2(feedChunks, getTimelineRequest);
}
