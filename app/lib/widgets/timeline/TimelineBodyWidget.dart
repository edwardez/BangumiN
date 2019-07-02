import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/timeline/common/FeedLoadType.dart';
import 'package:munin/models/bangumi/timeline/common/GetTimelineRequest.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineSource.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/timeline/FeedChunks.dart';
import 'package:munin/redux/timeline/TimelineActions.dart';
import 'package:munin/shared/utils/collections/common.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/widgets/shared/appbar/OneMuninBar.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';
import 'package:munin/widgets/shared/refresh/MuninRefresh.dart';
import 'package:munin/widgets/timeline/item/common/Actions.dart';
import 'package:munin/widgets/timeline/item/common/FeedTile.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

class TimelineBodyWidget extends StatefulWidget {
  final Widget appBar;
  final GetTimelineRequest getTimelineRequest;

  const TimelineBodyWidget({
    Key key,
    @required this.appBar,
    @required this.getTimelineRequest,
  })
      : assert(getTimelineRequest != null),
        assert(appBar != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    assert(appBar is OneMuninBar || appBar is SliverAppBar);
    return _TimelineBodyWidgetState();
  }
}

class _TimelineBodyWidgetState extends State<TimelineBodyWidget> {
  GlobalKey<MuninRefreshState> _muninRefreshKey =
      GlobalKey<MuninRefreshState>();

  IndexedWidgetBuilder _createItemBuilder(
      _ViewModel vm, bool hasFilterAllFeeds) {
    if (hasFilterAllFeeds) {
      return (BuildContext context, int index) {
        Semantics(child: Container(), excludeSemantics: true);
      };
    }

    return (BuildContext context, int index) {
      return FeedTile(
        appUsername: vm.appUsername,
        deleteFeedCallback: vm.deleteFeed,
        feed: vm.feedChunks.getFeedAt(index),
      );
    };
  }

  /// A widget that will show up if the timeline is empty
  _buildEmptyTimelineWidget() {
    Widget emptyTimelineWidget;

    if (widget.getTimelineRequest.timelineSource ==
        TimelineSource.UserProfile) {
      emptyTimelineWidget = Column(
        children: <Widget>[
          Text('时间线为空，可能因为：'),
          Text('1. $appOrBangumiHasAnError，下拉可重试'),
          Text(
              '2. 用户未发表任何${widget.getTimelineRequest.timelineCategoryFilter.chineseName}分类下的动态'),
          FlatButton(
            child: Text(checkWebVersionPrompt),
            onPressed: () {
              String username = widget.getTimelineRequest.username;
              String category = widget.getTimelineRequest.timelineCategoryFilter
                  .bangumiQueryParameterValue;

              return launch(
                  'https://${Application.environmentValue.bangumiMainHost}/user/$username/timeline?type=$category',
                  forceSafariVC: false);
            },
          )
        ],
      );
    } else {
      emptyTimelineWidget = Column(
        children: <Widget>[
          Text('时间线为空，可能因为：'),
          Text('1. $appOrBangumiHasAnError，下拉可重试'),
          Text('2. 您尚未关注任何已发表动态的用户'),
          FlatButton(
            child: Text(checkWebVersionPrompt),
            onPressed: () {
              return launch(bangumiTimelineUrl, forceSafariVC: false);
            },
          )
        ],
      );
    }

    return MuninPadding(
      child: emptyTimelineWidget,
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
    return feedChunks.filteredFeeds.length == 0 &&
        feedChunks.unfilteredFeeds.length != 0;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (Store store) =>
          _ViewModel.fromStore(store, widget.getTimelineRequest),
      onInitialBuild: (_ViewModel vm) {
        if (vm.feedChunks.isStale || vm.feedChunks.filteredFeeds.isEmpty) {
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
            itemCount:
                hasFilterAllFeeds ? 1 : vm.feedChunks.filteredFeeds.length,
            appBar: widget.appBar,
            emptyAfterRefreshWidget: _buildEmptyTimelineWidget(),
            noMoreItemsToLoad:
                vm.feedChunks.disableLoadingMore || vm.feedChunks.hasReachedEnd,
            noMoreItemsWidget: _buildNoMoreItemsWidget());
      },
    );
  }
}

class _ViewModel {
  /// user name of the user who is using the app
  final String appUsername;

  final FeedChunks feedChunks;
  final GetTimelineRequest getTimelineRequest;
  final Future Function(BuildContext context) fetchLatestFeed;
  final Future Function(BuildContext context) fetchOlderFeed;

  final DeleteFeedCallback deleteFeed;

  factory _ViewModel.fromStore(
      Store<AppState> store, GetTimelineRequest getTimelineRequest) {
    Future _fetchLatestFeed(BuildContext context) {
      FeedChunks feedChunks =
          store.state.timelineState.timeline[getTimelineRequest] ??
              FeedChunks();

      FeedLoadType feedLoadType;
      if (isIterableNullOrEmpty(feedChunks.unfilteredFeeds)) {
        feedLoadType = FeedLoadType.Initial;
      } else {
        feedLoadType = FeedLoadType.Newer;
      }

      final action = GetTimelineRequestAction(
        context: context,
        feedLoadType: feedLoadType,
        getTimelineRequest: getTimelineRequest,
      );
      store.dispatch(action);

      return action.completer.future;
    }

    Future _fetchOlderFeed(BuildContext context) {
      FeedLoadType feedLoadType = FeedLoadType.Older;

      final action = GetTimelineRequestAction(
          context: context,
          feedLoadType: feedLoadType,
          getTimelineRequest: getTimelineRequest);
      store.dispatch(action);

      return action.completer.future;
    }

    void _deleteFeed(BuildContext context, TimelineFeed feed) {
      deleteFeedHelper(store, context, getTimelineRequest, feed);
    }

    return _ViewModel(
      feedChunks: store.state.timelineState.timeline[getTimelineRequest] ??
          FeedChunks(),
      getTimelineRequest: getTimelineRequest,
      fetchLatestFeed: (context) => _fetchLatestFeed(context),
      fetchOlderFeed: (context) => _fetchOlderFeed(context),
      deleteFeed: _deleteFeed,
      appUsername: store.state.currentAuthenticatedUserBasicInfo.username,
    );
  }

  _ViewModel({
    @required this.feedChunks,
    @required this.getTimelineRequest,
    @required this.fetchLatestFeed,
    @required this.fetchOlderFeed,
    @required this.appUsername,
    @required this.deleteFeed,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          feedChunks == other.feedChunks &&
          getTimelineRequest == other.getTimelineRequest &&
          appUsername == other.appUsername;

  @override
  int get hashCode => hash3(feedChunks, getTimelineRequest, appUsername);
}
