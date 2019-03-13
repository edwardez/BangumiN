import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/timeline/common/TimelineUserInfo.dart';
import 'package:munin/widgets/shared/avatar/CachedCircleAvatar.dart';
import 'package:munin/widgets/shared/utils/ExpandedEmpty.dart';
import 'package:munin/widgets/shared/utils/SubjectStars.dart';

/// a commonly-used user list tile
/// optionally there is a score parameter which follows the actionName in subtitle,
/// this can be used in Collection Update cases
class TimelineUserListTile extends StatelessWidget {
  final TimelineUserInfo user;
  final int titleMaxLines;
  final double score;

  const TimelineUserListTile({
    Key key,
    @required this.user,
    this.titleMaxLines = 1,
    this.score,
  }) : super(key: key);

  List<Widget> _buildSubtitleComponents(
      {@required String actionName, @required String updatedAt, double score}) {
    if (score == null) {
      return [
        Expanded(
            child: Text(
          actionName,

          /// action should be at most 1 line, this is currently hard-coded and forced for aesthetic reason
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )),
        Text(updatedAt)
      ];
    } else {
      return [
        Text(actionName),
        SubjectStars(
          subjectScore: score,
        ),
        ExpandedEmpty(),
        Text(updatedAt)
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: CachedCircleAvatar(imageUrl: user.avatarImageUrl),
      subtitle: Row(
        children: _buildSubtitleComponents(
            actionName: user.actionName,
            updatedAt: user.updatedAt,
            score: this.score),
      ),
      title: Text(
        user.nickName,
        maxLines: titleMaxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
