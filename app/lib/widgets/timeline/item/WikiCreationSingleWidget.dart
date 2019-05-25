import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/WikiCreationSingle.dart';
import 'package:munin/widgets/shared/common/UserListTile.dart';
import 'package:munin/widgets/timeline/TimelineBodyWidget.dart';
import 'package:munin/widgets/timeline/item/common/FeedMoreActionsMenu.dart';
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
        UserListTile.fromUser(
          user: wikiCreationSingle.user,
          trailing: buildTrailingWidget(wikiCreationSingle, onDeleteFeed),
        ),
        TimelineCommonListTile(title: wikiCreationSingle.newItemName),
      ],
    );
  }
}
