import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/WikiCreationSingle.dart';
import 'package:munin/widgets/shared/common/UserListTile.dart';
import 'package:munin/widgets/timeline/item/common/TimelineCommonListTile.dart';

class WikiCreationSingleWidget extends StatelessWidget {
  final WikiCreationSingle wikiCreationSingle;

  WikiCreationSingleWidget({@required this.wikiCreationSingle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserListTile.fromUser(
          user: wikiCreationSingle.user,
        ),
        TimelineCommonListTile(title: wikiCreationSingle.newItemName),
      ],
    );
  }
}
