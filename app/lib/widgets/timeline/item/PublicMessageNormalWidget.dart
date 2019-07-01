import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/PublicMessageNormal.dart';
import 'package:munin/widgets/shared/common/UserActionTile.dart';
import 'package:munin/widgets/shared/html/BangumiHtml.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';
import 'package:munin/widgets/timeline/item/common/FeedMoreActionsMenu.dart';
import 'package:munin/widgets/timeline/item/common/FeedTile.dart';
import 'package:munin/widgets/timeline/message/FullPublicMessageWidget.dart';

class PublicMessageNormalWidget extends StatelessWidget {
  final PublicMessageNormal publicMessageNormal;
  final double paddingFromItemToTop;
  final double paddingBetweenCommentIconAndCount;
  final DeleteFeedCallback onDeleteFeed;

  /// Whether allows redirecting to a [FullPublicMessageWidget].
  /// Needs to be set to false if [PublicMessageNormalWidget] is already
  /// on a [FullPublicMessageWidget] to avoid cyclic redirect,
  final bool allowRedirectToFullMessage;

  const PublicMessageNormalWidget({
    Key key,
    @required this.publicMessageNormal,
    this.paddingFromItemToTop = 3,
    this.paddingBetweenCommentIconAndCount = 2,
    this.onDeleteFeed,
    this.allowRedirectToFullMessage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserActionTile.fromUser(
            user: publicMessageNormal.user,
            trailing: buildTrailingWidget(publicMessageNormal, onDeleteFeed),
          ),
          BangumiHtml(
            html: publicMessageNormal.contentHtml,
          ),
          InkWell(
            child: Padding(
              padding: EdgeInsets.only(top: paddingFromItemToTop),
              child: Row(
                children: <Widget>[
                  Icon(AdaptiveIcons.conversationIconData),
                  Padding(
                    padding: EdgeInsets.only(
                        left: paddingBetweenCommentIconAndCount),
                    child: Text(publicMessageNormal.replyCount.toString()),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      onTap: allowRedirectToFullMessage
          ? () {
        Navigator.push<bool>(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  FullPublicMessageWidget(
                    mainMessage: publicMessageNormal,
                  )),
        );
      }
          : null,
    );
  }
}
