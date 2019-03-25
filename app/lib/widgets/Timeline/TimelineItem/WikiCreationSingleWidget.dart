import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/timeline/WikiCreationSingle.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/TimelineCommonListTile.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/TimelineUserListTile.dart';

class WikiCreationSingleWidget extends StatelessWidget {
  final WikiCreationSingle wikiCreationSingle;

  WikiCreationSingleWidget({@required this.wikiCreationSingle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TimelineUserListTile.fromUser(
          user: wikiCreationSingle.user,
        ),
        TimelineCommonListTile(title: wikiCreationSingle.newItemName),
      ],
    );
  }
}
