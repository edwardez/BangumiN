import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/FriendshipCreationSingle.dart';
import 'package:munin/widgets/shared/avatar/CachedCircleAvatar.dart';
import 'package:munin/widgets/shared/common/UserListTile.dart';
import 'package:munin/widgets/shared/utils/common.dart';
import 'package:munin/widgets/timeline/TimelineBodyWidget.dart';
import 'package:munin/widgets/timeline/item/common/FeedMoreActionsMenu.dart';
import 'package:munin/widgets/timeline/item/common/TimelineCommonListTile.dart';

class FriendshipCreationSingleWidget extends StatelessWidget {
  final FriendshipCreationSingle friendshipCreationSingle;
  final DeleteFeedCallback onDeleteFeed;

  const FriendshipCreationSingleWidget(
      {Key key, @required this.friendshipCreationSingle, @required this.onDeleteFeed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserListTile.fromUser(
          user: friendshipCreationSingle.user,
          trailing: buildTrailingWidget(friendshipCreationSingle, onDeleteFeed),
        ),
        TimelineCommonListTile(
          leadingWidget: CachedCircleAvatar(
            imageUrl: friendshipCreationSingle.friendAvatar.medium,
            navigateToUserRouteOnTap: true,
            username: friendshipCreationSingle.friendId,
          ),
          title: friendshipCreationSingle.friendNickName,
            onTap: generateOnTapCallbackForBangumiContent(
                contentType: friendshipCreationSingle.bangumiContent,
                id: friendshipCreationSingle.friendId,
                context: context)
        ),
      ],
    );
  }
}
