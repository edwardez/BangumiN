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
import 'package:munin/models/bangumi/timeline/common/FetchTimelineRequest.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/timeline/FeedChunks.dart';
import 'package:munin/redux/timeline/TimelineActions.dart';
import 'package:munin/shared/utils/collections/common.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/widgets/Timeline/TimelineItem/BlogCreationSingleWidget.dart';
import 'package:munin/widgets/Timeline/TimelineItem/CollectionUpdateSingle.dart';
import 'package:munin/widgets/Timeline/TimelineItem/FriendshipCreationSingleWidget.dart';
import 'package:munin/widgets/Timeline/TimelineItem/GroupJoinSingleWidget.dart';
import 'package:munin/widgets/Timeline/TimelineItem/IndexFavoriteSingleWidget.dart';
import 'package:munin/widgets/Timeline/TimelineItem/MonoFavoriteSingle.dart';
import 'package:munin/widgets/Timeline/TimelineItem/ProgressUpdateEpisodeSingleWidget.dart';
import 'package:munin/widgets/Timeline/TimelineItem/ProgressUpdateEpisodeUntilWidget.dart';
import 'package:munin/widgets/Timeline/TimelineItem/PublicMessageNoReplyWidget.dart';
import 'package:munin/widgets/Timeline/TimelineItem/PublicMessageNormalWidget.dart';
import 'package:munin/widgets/Timeline/TimelineItem/StatusUpdateMultipleWidget.dart';
import 'package:munin/widgets/Timeline/TimelineItem/UnknownTimelineActivityWidget.dart';
import 'package:munin/widgets/Timeline/TimelineItem/WikiCreationSingleWidget.dart';
import 'package:munin/widgets/shared/appbar/OneMuninBar.dart';
import 'package:munin/widgets/shared/avatar/CachedCircleAvatar.dart';
import 'package:munin/widgets/shared/refresh/MuninRefresh.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

class TimelineBody extends StatefulWidget {
  final OneMuninBar oneMuninBar;
  final FetchTimelineRequest fetchTimelineRequest;

  const TimelineBody(
      {Key key,
      @required this.oneMuninBar,
      @required this.fetchTimelineRequest})
      : assert(fetchTimelineRequest != null),
        assert(oneMuninBar != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TimelineBodyState();
  }
}

class _TimelineBodyState extends State<TimelineBody> {
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

  IndexedWidgetBuilder _createItemBuilder(_ViewModel viewModel) {
    FeedChunks feedChunks = viewModel.feedChunks;
    return (BuildContext context, int index) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CachedCircleAvatar(
            imageUrl: feedChunks.getFeedAt(index)?.user?.avatarImageUrl,
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
        Text('时间线为空，可能的原因'),
        Text('1. 应用或bangumi出错，下拉可重试'),
        Text('2. 您尚未关注任何已发表动态的用户'),
        FlatButton(
          child: Text('查看网页版'),
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

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (Store store) =>
          _ViewModel.fromStore(store, widget.fetchTimelineRequest),
      onInitialBuild: (_ViewModel vm) {
        if (vm.feedChunks.isStale || vm.feedChunks.first.isEmpty) {
          _muninRefreshKey?.currentState?.callOnRefresh();
        }
      },
      builder: (BuildContext context, _ViewModel vm) {
        return MuninRefresh(
            key: _muninRefreshKey,
            onRefresh: () {
              return vm.fetchLatestFeed(context);
            },
            itemBuilder: _createItemBuilder(vm),
            onLoadMore: () {
              return vm.fetchOlderFeed(context);
            },
            refreshWidgetStyle: RefreshWidgetStyle.Material,
            itemCount: vm.feedChunks.first.length,
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
  final FetchTimelineRequest fetchTimelineRequest;
  final Future Function(BuildContext context) fetchLatestFeed;
  final Future Function(BuildContext context) fetchOlderFeed;

  factory _ViewModel.fromStore(
      Store<AppState> store, FetchTimelineRequest fetchTimelineRequest) {
    Future _fetchLatestFeed(BuildContext context) {
      FeedChunks feedChunks =
          store.state.timelineState.timeline[fetchTimelineRequest] ??
              FeedChunks();
      FeedLoadType feedLoadType;
      if (isIterableNullOrEmpty(feedChunks.first)) {
        feedLoadType = FeedLoadType.Initial;
      } else {
        feedLoadType = FeedLoadType.Newer;
      }

      final action = LoadTimelineRequest(
          context: context,
          feedLoadType: feedLoadType,
          fetchTimelineRequest: fetchTimelineRequest);
      store.dispatch(action);

      return action.completer.future;
    }

    Future _fetchOlderFeed(BuildContext context) {
      FeedLoadType feedLoadType = FeedLoadType.Older;

      final action = LoadTimelineRequest(
          context: context,
          feedLoadType: feedLoadType,
          fetchTimelineRequest: fetchTimelineRequest);
      store.dispatch(action);

      return action.completer.future;
    }

    return _ViewModel(
      feedChunks: store.state.timelineState.timeline[fetchTimelineRequest] ??
          FeedChunks(),
      fetchTimelineRequest: fetchTimelineRequest,
      fetchLatestFeed: (context) => _fetchLatestFeed(context),
      fetchOlderFeed: (context) => _fetchOlderFeed(context),
    );
  }

  _ViewModel(
      {@required this.feedChunks,
      @required this.fetchTimelineRequest,
      @required this.fetchLatestFeed,
      @required this.fetchOlderFeed});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          feedChunks == other.feedChunks &&
          fetchTimelineRequest == other.fetchTimelineRequest;

  @override
  int get hashCode => hash2(feedChunks.hashCode, fetchTimelineRequest.hashCode);
}
