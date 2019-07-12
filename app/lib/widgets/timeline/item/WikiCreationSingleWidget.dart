import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/WikiCreationSingle.dart';
import 'package:munin/widgets/shared/common/UserActionTile.dart';
import 'package:munin/widgets/shared/utils/common.dart';
import 'package:munin/widgets/timeline/item/common/FeedMoreActionsMenu.dart';
import 'package:munin/widgets/timeline/item/common/FeedTile.dart';
import 'package:munin/widgets/timeline/item/common/TimelineCommonListTile.dart';

class WikiCreationSingleWidget extends StatelessWidget {
  final WikiCreationSingle wikiCreationSingle;
  final DeleteFeedCallback onDeleteFeed;

  WikiCreationSingleWidget(
      {@required this.wikiCreationSingle, @required this.onDeleteFeed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserActionTile.fromUser(
          user: wikiCreationSingle.user,
          trailing: buildTrailingWidget(wikiCreationSingle, onDeleteFeed),
        ),
        TimelineCommonListTile(
          title: wikiCreationSingle.newItemName,
          onTap: generateOnTapCallbackForBangumiContent(
              contentType: wikiCreationSingle.bangumiContent,
              id: wikiCreationSingle.newItemId,
              context: context),
        ),
      ],
    );
  }
}
