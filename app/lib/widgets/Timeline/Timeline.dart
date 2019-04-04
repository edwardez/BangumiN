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
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/timeline/FeedChunks.dart';
import 'package:munin/redux/timeline/TimelineActions.dart';
import 'package:munin/redux/timeline/TimelineState.dart';
import 'package:munin/shared/utils/collections/common.dart';
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
import 'package:munin/widgets/shared/avatar/CachedCircleAvatar.dart';
import 'package:redux/redux.dart';

class MuninTimeline extends StatelessWidget {
  getWidgetByType(timelineItem) {
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

  Widget _buildFeeds(_ViewModel viewModel) {
    int loadButtonOffset = 1;

    FeedChunks feedChunks = viewModel.timelineState.feedChunks;

    if (feedChunks == null || feedChunks.feedsCount == 0) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Center(
            child: Text('Spinning up! '),
          )
        ],
      );
    }

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(0),
      itemBuilder: (BuildContext context, int index) {
        if (index < feedChunks.first.length) {
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
        }

        if (index == feedChunks.first.length) {
          return Center(
            child: OutlineButton(
              child: Text('加载更多'),
              onPressed: () => viewModel.fetchOlderFeed(context),
            ),
          );
        }

        if (index > feedChunks.first.length) {
          return getWidgetByType(
              feedChunks.getFeedAt(index - loadButtonOffset));
        }
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemCount: feedChunks.feedsCount + loadButtonOffset,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (Store store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel vm) {
        return Container(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: 0,
            top: 0,
          ),
          child: RefreshIndicator(
            onRefresh: () => vm.fetchLatestFeed(context),
            child: _buildFeeds(vm),
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final TimelineState timelineState;
  final Function(BuildContext context) fetchLatestFeed;
  final Function(BuildContext context) fetchOlderFeed;

  factory _ViewModel.fromStore(Store<AppState> store) {
    _fetchLatestFeed(BuildContext context) {
      FeedLoadType feedLoadType;
      if (isIterableNullOrEmpty(store.state.timelineState.feedChunks.first)) {
        feedLoadType = FeedLoadType.Initial;
      } else {
        feedLoadType = FeedLoadType.Newer;
      }

      final action =
          LoadTimelineFeed(context: context, feedLoadType: feedLoadType);
      store.dispatch(action);

      return action.completer.future;
    }

    _fetchOlderFeed(BuildContext context) {
      FeedLoadType feedLoadType = FeedLoadType.Older;

      final action =
          LoadTimelineFeed(context: context, feedLoadType: feedLoadType);
      store.dispatch(action);

      return action.completer.future;
    }

    return _ViewModel(
      timelineState: store.state.timelineState,
      fetchLatestFeed: (context) => _fetchLatestFeed(context),
      fetchOlderFeed: (context) => _fetchOlderFeed(context),
    );
  }

  _ViewModel(
      {@required this.timelineState,
      @required this.fetchLatestFeed,
      @required this.fetchOlderFeed});

  @override
  int get hashCode => timelineState.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is _ViewModel &&
            timelineState == other.timelineState;
  }
}
