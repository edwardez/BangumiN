import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/timeline/MonoFavoriteSingle.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/ItemWithRoundedCorner.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/TimelineUserListTile.dart';
import 'package:munin/widgets/shared/cover/CachedRoundedCover.dart';

enum MonoType { person, character }

// currently person(real) and character(fictional) shares exactly same code, we call them 'mono'(japanese romaji) so a common widget is created
class MonoFavoriteSingleWidget extends StatelessWidget {
  final MonoFavoriteSingle monoFavoriteSingle;

  const MonoFavoriteSingleWidget({Key key, @required this.monoFavoriteSingle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TimelineUserListTile(
          user: monoFavoriteSingle.user,
        ),
        ItemWithRoundedCorner(
          leadingWidget: CachedRoundedCover(
              imageUrl: monoFavoriteSingle.monoAvatarImageUrl),
          title: monoFavoriteSingle.monoName,
        ),
      ],
    );
  }
}
