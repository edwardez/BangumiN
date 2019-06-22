import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/IndexFavoriteSingle.dart';
import 'package:munin/widgets/shared/common/UserListTile.dart';
import 'package:munin/widgets/shared/utils/common.dart';
import 'package:munin/widgets/timeline/TimelineBodyWidget.dart';
import 'package:munin/widgets/timeline/item/common/FeedMoreActionsMenu.dart';
import 'package:munin/widgets/timeline/item/common/TimelineCommonListTile.dart';

class IndexFavoriteSingleWidget extends StatelessWidget {
  final IndexFavoriteSingle indexFavoriteSingle;
  final DeleteFeedCallback onDeleteFeed;

  const IndexFavoriteSingleWidget(
      {Key key,
      @required this.indexFavoriteSingle,
      @required this.onDeleteFeed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserListTile.fromUser(
          user: indexFavoriteSingle.user,
          trailing: buildTrailingWidget(indexFavoriteSingle, onDeleteFeed),
        ),
        TimelineCommonListTile(
          title: indexFavoriteSingle.title,
          subtitle: indexFavoriteSingle.summary,
          onTap: generateOnTapCallbackForBangumiContent(
              contentType: indexFavoriteSingle.bangumiContent,
              id: indexFavoriteSingle.id,
              context: context),
        ),
      ],
    );
  }
}
