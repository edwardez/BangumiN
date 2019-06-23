import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/GroupJoinSingle.dart';
import 'package:munin/widgets/shared/common/UserListTile.dart';
import 'package:munin/widgets/shared/cover/CachedRoundedCover.dart';
import 'package:munin/widgets/shared/utils/common.dart';
import 'package:munin/widgets/timeline/TimelineBodyWidget.dart';
import 'package:munin/widgets/timeline/item/common/FeedMoreActionsMenu.dart';
import 'package:munin/widgets/timeline/item/common/TimelineCommonListTile.dart';

class GroupJoinSingleWidget extends StatelessWidget {
  final GroupJoinSingle groupJoinSingle;
  final DeleteFeedCallback onDeleteFeed;

  const GroupJoinSingleWidget(
      {Key key, @required this.groupJoinSingle, @required this.onDeleteFeed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserListTile.fromUser(
          user: groupJoinSingle.user,
          trailing: buildTrailingWidget(groupJoinSingle, onDeleteFeed),
        ),
        TimelineCommonListTile(
          leadingWidget: CachedRoundedCover.asGridSize(
              imageUrl: groupJoinSingle.groupIcon.medium),
          title: groupJoinSingle.groupName,
          subtitle: groupJoinSingle.groupDescription,
          onTap: generateOnTapCallbackForBangumiContent(
              contentType: groupJoinSingle.bangumiContent,
              id: groupJoinSingle.groupId,
              context: context),
        ),
      ],
    );
  }
}
