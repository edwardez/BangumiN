import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/PublicMessageNoReply.dart';
import 'package:munin/widgets/shared/common/UserListTile.dart';

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
        UserListTile.fromUser(
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
