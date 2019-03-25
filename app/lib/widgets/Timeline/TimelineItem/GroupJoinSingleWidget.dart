import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/timeline/GroupJoinSingle.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/TimelineCommonListTile.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/TimelineUserListTile.dart';
import 'package:munin/widgets/shared/cover/CachedRoundedCover.dart';

class GroupJoinSingleWidget extends StatelessWidget {
  final GroupJoinSingle groupJoinSingle;

  const GroupJoinSingleWidget({Key key, @required this.groupJoinSingle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TimelineUserListTile.fromUser(
          user: groupJoinSingle.user,
        ),
        TimelineCommonListTile(
          leadingWidget:
              CachedRoundedCover(imageUrl: groupJoinSingle.groupCoverImageUrl),
          title: groupJoinSingle.groupName,
          subtitle: groupJoinSingle.groupDescription,
        ),
      ],
    );
  }
}
