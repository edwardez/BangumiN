import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/PublicMessageNormal.dart';
import 'package:munin/widgets/shared/common/UserListTile.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';

class PublicMessageNormalWidget extends StatelessWidget {
  final PublicMessageNormal publicMessageNormal;
  final double paddingFromItemToTop;
  final double paddingBetweenCommentIconAndCount;

  const PublicMessageNormalWidget({
    Key key,
    @required this.publicMessageNormal,
    this.paddingFromItemToTop = 3,
    this.paddingBetweenCommentIconAndCount = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserListTile.fromUser(
          user: publicMessageNormal.user,
        ),
        Row(
          children: <Widget>[
            Flexible(
              child: Text(publicMessageNormal.content),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: paddingFromItemToTop),
          child: Row(
            children: <Widget>[
              Icon(AdaptiveIcons.conversationIconData),
              Padding(
                padding:
                EdgeInsets.only(left: paddingBetweenCommentIconAndCount),
                child: Text(publicMessageNormal.replyCount.toString()),
              )
            ],
          ),
        ),
      ],
    );
  }
}