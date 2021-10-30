import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:munin/shared/utils/time/TimeUtils.dart';
import 'package:munin/widgets/shared/text/ListTileSubtitleWidget.dart';

/// A commonly-used tile that displays user's name, its action, time and more.
/// optionally there is a score parameter which follows the actionName in subtitle,
class UserActionTile extends StatelessWidget {
  final String nickName;
  final String actionName;
  final int updatedAt;
  final DisplayTimeIn timeDisplayFormat;

  /// An additional action widget that's on the same line with the user name
  /// and placed to the end
  /// It's like `trailing` in [ListTile]
  final Widget trailing;

  /// see [AbsoluteTimeFormat]
  /// This won't work if time is displayed in relative format
  final AbsoluteTimeFormat formatAbsoluteTimeAs;
  final int titleMaxLines;
  final double score;

  UserActionTile({
    Key key,
    @required this.nickName,
    @required this.actionName,
    @required this.updatedAt,
    this.score,
    this.titleMaxLines = 1,
    this.timeDisplayFormat = DisplayTimeIn.AlwaysRelative,
    this.formatAbsoluteTimeAs = AbsoluteTimeFormat.Full,
    this.trailing,
  });

  UserActionTile.fromUser({
    Key key,
    FeedMetaInfo user,
    this.titleMaxLines = 1,
    this.timeDisplayFormat = DisplayTimeIn.AlwaysRelative,
    this.score,
    this.formatAbsoluteTimeAs = AbsoluteTimeFormat.Full,
    this.trailing,
  })  : actionName = user.actionName,
        updatedAt = user.updatedAt,
        nickName = user.nickName,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Text(
                nickName,
                maxLines: titleMaxLines,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              fit: FlexFit.tight,
            ),
          ]
            ..addAll(trailing == null ? [] : [trailing]),
        ),
        ListTileSubtitleWidget(
          actionName: actionName,
          updatedAt: updatedAt,
          score: score,

          /// [updatedAt] on timeline is parsed by relative time on bangumi WebPage
          /// timeline, thus using absolute time might results in incorrect time display
          timeDisplayFormat: timeDisplayFormat,
          formatAbsoluteTimeAs: formatAbsoluteTimeAs,
        )
      ],
    );
  }
}
