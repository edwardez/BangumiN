import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/IndexFavoriteSingle.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/TimelineCommonListTile.dart';
import 'package:munin/widgets/shared/common/UserListTile.dart';

class IndexFavoriteSingleWidget extends StatelessWidget {
  final IndexFavoriteSingle indexFavoriteSingle;

  const IndexFavoriteSingleWidget({Key key, @required this.indexFavoriteSingle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserListTile.fromUser(
          user: indexFavoriteSingle.user,
        ),
        TimelineCommonListTile(
          title: indexFavoriteSingle.title,
          subtitle: indexFavoriteSingle.summary,
        ),
      ],
    );
  }
}
