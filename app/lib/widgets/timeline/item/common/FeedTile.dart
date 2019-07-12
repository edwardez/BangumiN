import 'package:flutter/material.dart';
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
import 'package:munin/models/bangumi/timeline/common/TimelineFeed.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/avatar/CachedCircleAvatar.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';
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

typedef DeleteFeedCallback = void Function(
    BuildContext context, TimelineFeed feed);

/// A commonly used feed tile. Layout is
/// avatar | feed body
///padding | feed body
class FeedTile extends StatelessWidget {
  final String appUsername;

  final DeleteFeedCallback deleteFeedCallback;
  final TimelineFeed feed;

  /// An optional widget that's under feed body.
  final Widget childUnderFeedBody;

  /// Whether allows redirecting to full page of a timeline feed,
  /// Currently only [PublicMessageNormalWidget]　implements this.
  final bool allowRedirectToFullPage;

  const FeedTile({
    Key key,
    @required this.appUsername,
    @required this.deleteFeedCallback,
    @required this.feed,
    this.allowRedirectToFullPage = true,
    this.childUnderFeedBody,
  }) : super(key: key);

  Widget findWidgetByType(
    TimelineFeed timelineItem,
    String appUsername,
    DeleteFeedCallback dispatchDeleteAction,
  ) {
    String feedUsername = timelineItem?.user?.username;

    DeleteFeedCallback callback;

    /// Sets callback to a non-null dispatchDeleteAction only if user is authorized
    /// to do so
    if (feedUsername != null && feedUsername == appUsername) {
      callback = dispatchDeleteAction;
    }

    if (timelineItem is PublicMessageNoReply) {
      return PublicMessageNoReplyWidget(
        publicMessageNoReply: timelineItem,
      );
    }
    if (timelineItem is PublicMessageNormal) {
      return PublicMessageNormalWidget(
        publicMessageNormal: timelineItem,
        onDeleteFeed: callback,
        allowRedirectToFullMessage: allowRedirectToFullPage,
      );
    }
    if (timelineItem is BlogCreationSingle) {
      return BlogCreationSingleWidget(
        blogCreationSingle: timelineItem,
        onDeleteFeed: callback,
      );
    }
    if (timelineItem is CollectionUpdateSingle) {
      return CollectionUpdateSingleWidget(
        collectionUpdateSingle: timelineItem,
        onDeleteFeed: callback,
      );
    }
    if (timelineItem is FriendshipCreationSingle) {
      return FriendshipCreationSingleWidget(
        friendshipCreationSingle: timelineItem,
        onDeleteFeed: callback,
      );
    }
    if (timelineItem is GroupJoinSingle) {
      return GroupJoinSingleWidget(
        groupJoinSingle: timelineItem,
        onDeleteFeed: callback,
      );
    }
    if (timelineItem is IndexFavoriteSingle) {
      return IndexFavoriteSingleWidget(
        indexFavoriteSingle: timelineItem,
        onDeleteFeed: callback,
      );
    }
    if (timelineItem is MonoFavoriteSingle) {
      return MonoFavoriteSingleWidget(
        monoFavoriteSingle: timelineItem,
        onDeleteFeed: callback,
      );
    }
    if (timelineItem is ProgressUpdateEpisodeSingle) {
      return ProgressUpdateEpisodeSingleWidget(
        progressUpdateEpisodeSingle: timelineItem,
        onDeleteFeed: callback,
      );
    }
    if (timelineItem is ProgressUpdateEpisodeUntil) {
      return ProgressUpdateEpisodeUntilWidget(
        progressUpdateEpisodeUntil: timelineItem,
        onDeleteFeed: callback,
      );
    }
    if (timelineItem is StatusUpdateMultiple) {
      return StatusUpdateMultipleWidget(
        statusUpdateMultiple: timelineItem,
        onDeleteFeed: callback,
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
        onDeleteFeed: callback,
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return MuninPadding.vertical3xOffset(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (feed?.user?.username != null)
            CachedCircleAvatar(
              imageUrl: feed?.user?.avatar?.medium,
              navigateToUserRouteOnTap: true,
              username: feed.user.username,
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: baseOffset),
                  child:
                      findWidgetByType(feed, appUsername, deleteFeedCallback),
                ),
                if (childUnderFeedBody != null) childUnderFeedBody,
              ],
            ),
          )
        ],
      ),
    );
  }
}
