import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/timeline/WikiCreationSingle.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/ItemWithRoundedCorner.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/TimelineUserListTile.dart';

class WikiCreationSingleWidget extends StatelessWidget {
  final WikiCreationSingle wikiCreationSingle;

  WikiCreationSingleWidget({@required this.wikiCreationSingle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TimelineUserListTile(
          user: wikiCreationSingle.user,
        ),
        ItemWithRoundedCorner(title: wikiCreationSingle.newItemName),
      ],
    );
  }
}
