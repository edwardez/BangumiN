import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/timeline/PublicMessageNoReply.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/TimelineUserListTile.dart';

/// a special public message that's published by system and un-deletable
/// [PublicMessageNameChange] and [PublicMessageSignChange] currently shares this widget
class PublicMessageNoReplyWidget extends StatelessWidget {
  final PublicMessageNoReply publicMessageNoReply;

  const PublicMessageNoReplyWidget(
      {Key key, @required this.publicMessageNoReply})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TimelineUserListTile(
          user: publicMessageNoReply.user,
        ),
        Row(
          children: <Widget>[
            Flexible(
              child: Text(publicMessageNoReply.content),
            )
          ],
        ),
      ],
    );
  }
}
