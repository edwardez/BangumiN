import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/PublicMessageNormal.dart';
import 'package:munin/widgets/shared/common/UserListTile.dart';
import 'package:munin/widgets/shared/html/BangumiHtml.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';
import 'package:munin/widgets/timeline/TimelineBodyWidget.dart';
import 'package:munin/widgets/timeline/item/common/FeedMoreActionsMenu.dart';

class PublicMessageNormalWidget extends StatelessWidget {
  final PublicMessageNormal publicMessageNormal;
  final double paddingFromItemToTop;
  final double paddingBetweenCommentIconAndCount;
  final DeleteFeedCallback onDeleteFeed;

  const PublicMessageNormalWidget({
    Key key,
    @required this.publicMessageNormal,
    this.paddingFromItemToTop = 3,
    this.paddingBetweenCommentIconAndCount = 2,
    this.onDeleteFeed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        UserListTile.fromUser(
          user: publicMessageNormal.user,
          trailing: buildTrailingWidget(publicMessageNormal, onDeleteFeed),
        ),
        BangumiHtml(
          html: publicMessageNormal.contentHtml,
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
