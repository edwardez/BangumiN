import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/timeline/IndexFavoriteSingle.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/ItemWithRoundedCorner.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/TimelineUserListTile.dart';

class IndexFavoriteSingleWidget extends StatelessWidget {
  final IndexFavoriteSingle indexFavoriteSingle;

  const IndexFavoriteSingleWidget({Key key, @required this.indexFavoriteSingle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TimelineUserListTile(
          user: indexFavoriteSingle.user,
        ),
        ItemWithRoundedCorner(
          title: indexFavoriteSingle.title,
          subtitle: indexFavoriteSingle.summary,
        ),
      ],
    );
  }
}
