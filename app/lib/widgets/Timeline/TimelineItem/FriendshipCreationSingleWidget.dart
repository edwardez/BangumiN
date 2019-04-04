import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/FriendshipCreationSingle.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/TimelineCommonListTile.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/TimelineUserListTile.dart';
import 'package:munin/widgets/shared/avatar/CachedCircleAvatar.dart';

class FriendshipCreationSingleWidget extends StatelessWidget {
  final FriendshipCreationSingle friendshipCreationSingle;

  const FriendshipCreationSingleWidget(
      {Key key, @required this.friendshipCreationSingle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TimelineUserListTile.fromUser(
          user: friendshipCreationSingle.user,
        ),
        TimelineCommonListTile(
          leadingWidget: CachedCircleAvatar(
              imageUrl: friendshipCreationSingle.friendAvatarImageUrl),
          title: friendshipCreationSingle.friendNickName,
        ),
      ],
    );
  }
}
