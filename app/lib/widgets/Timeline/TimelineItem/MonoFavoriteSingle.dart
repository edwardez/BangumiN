import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/MonoFavoriteSingle.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/TimelineCommonListTile.dart';
import 'package:munin/widgets/shared/common/UserListTile.dart';
import 'package:munin/widgets/shared/cover/CachedRoundedCover.dart';

// currently person(real) and character(fictional) shares exactly same code, we call them 'mono'(japanese romaji) so a common widget is created
class MonoFavoriteSingleWidget extends StatelessWidget {
  final MonoFavoriteSingle monoFavoriteSingle;

  const MonoFavoriteSingleWidget({Key key, @required this.monoFavoriteSingle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserListTile.fromUser(
          user: monoFavoriteSingle.user,
        ),
        TimelineCommonListTile(
          leadingWidget: CachedRoundedCover.asGridSize(
              imageUrl: monoFavoriteSingle.monoAvatarImageUrl),
          title: monoFavoriteSingle.monoName,
        ),
      ],
    );
  }
}
