import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:munin/widgets/shared/text/ListTileSubtitleWidget.dart';

/// a commonly-used user list tile
/// optionally there is a score parameter which follows the actionName in subtitle,
class TimelineUserListTile extends StatelessWidget {
  final String nickName;
  final String actionName;
  final int updatedAt;
  final int titleMaxLines;
  final double score;

  TimelineUserListTile({
    Key key,
    @required this.nickName,
    @required this.actionName,
    @required this.updatedAt,
    this.titleMaxLines = 1,
    this.score,
  });

  TimelineUserListTile.fromUser({
    Key key,
    FeedMetaInfo user,
    this.titleMaxLines = 1,
    this.score,
  })
      : actionName = user.actionName,
        updatedAt = user.updatedAt,
        nickName = user.nickName,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Text(
                  nickName,
                  maxLines: titleMaxLines,
                  overflow: TextOverflow.ellipsis,
                  style: Theme
                      .of(context)
                      .textTheme
                      .subhead,
                ),
              )
            ],
          ),
          ListTileSubtitleWidget(
              actionName: actionName,
              updatedAt: updatedAt,
              score: this.score)
        ],
      ),
    );
  }
}
