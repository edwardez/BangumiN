import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/MonoFavoriteSingle.dart';
import 'package:munin/widgets/shared/common/UserActionTile.dart';
import 'package:munin/widgets/shared/cover/CachedRoundedCover.dart';
import 'package:munin/widgets/shared/utils/common.dart';
import 'package:munin/widgets/timeline/item/common/FeedMoreActionsMenu.dart';
import 'package:munin/widgets/timeline/item/common/FeedTile.dart';
import 'package:munin/widgets/timeline/item/common/TimelineCommonListTile.dart';

// currently person(real) and character(fictional) shares exactly same code, we call them 'mono'(japanese romaji) so a common widget is created
class MonoFavoriteSingleWidget extends StatelessWidget {
  final MonoFavoriteSingle monoFavoriteSingle;
  final DeleteFeedCallback onDeleteFeed;

  const MonoFavoriteSingleWidget(
      {Key key, @required this.monoFavoriteSingle, @required this.onDeleteFeed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserActionTile.fromUser(
          user: monoFavoriteSingle.user,
          trailing: buildTrailingWidget(monoFavoriteSingle, onDeleteFeed),
        ),
        TimelineCommonListTile(
          leadingWidget: CachedRoundedCover.asGridSize(
              imageUrl: monoFavoriteSingle.avatar.grid),
          title: monoFavoriteSingle.monoName,
          onTap: generateOnTapCallbackForBangumiContent(
              contentType: monoFavoriteSingle.bangumiContent,
              id: monoFavoriteSingle.id,
              context: context),
        ),
      ],
    );
  }
}
