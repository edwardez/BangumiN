import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/timeline/DoujinActivitySingle.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/ItemWithRoundedCorner.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/TimelineUserListTile.dart';
import 'package:munin/widgets/shared/cover/CachedRoundedCover.dart';

class DoujinActivitySingleWidget extends StatelessWidget {
  final DoujinActivitySingle doujinActivitySingle;

  const DoujinActivitySingleWidget(
      {Key key, @required this.doujinActivitySingle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TimelineUserListTile(
          user: doujinActivitySingle.user,
        ),
        ItemWithRoundedCorner(
          leadingWidget: CachedRoundedCover(
            imageUrl: doujinActivitySingle?.imageUrl ??
                'https://lain.bgm.tv/pic/user/m/icon.jpg',
          ),
          title: doujinActivitySingle.activityTargetName,
        ),
      ],
    );
  }
}
