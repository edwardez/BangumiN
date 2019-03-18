import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/timeline/common/FeedMetaInfo.dart';
import 'package:munin/widgets/shared/utils/ExpandedEmpty.dart';
import 'package:munin/widgets/shared/utils/SubjectStars.dart';

/// a commonly-used user list tile
/// optionally there is a score parameter which follows the actionName in subtitle,
class TimelineUserListTile extends StatelessWidget {
  final FeedMetaInfo user;
  final int titleMaxLines;
  final double score;

  const TimelineUserListTile({
    Key key,
    @required this.user,
    this.titleMaxLines = 1,
    this.score,
  }) : super(key: key);

  _captionTextStyle(BuildContext context) {
    /// text style of action and time
    /// style and size is intentionally hard coded(like [ListTile])
    return Theme
        .of(context)
        .textTheme
        .caption
        .copyWith(
      fontSize: 14,
    );
  }

  List<Widget> _buildSubtitleComponents({@required String actionName,
    @required String updatedAt,
    @required BuildContext context,
    double score}) {
    if (score == null) {
      return [
        Expanded(
            child: Text(
          actionName,
              style: _captionTextStyle(context),
          /// action should be at most 1 line, this is currently hard-coded and forced for aesthetic reason
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )),
        Text(
          updatedAt,
          style: _captionTextStyle(context),
        )
      ];
    } else {
      /// if text overflows there will be an error
      /// however length of this text is predictable so it should be fine
      return [
        Text(
          actionName,
          style: _captionTextStyle(context),
        ),
        SubjectStars(
          subjectScore: score,
        ),
        ExpandedEmpty(),
        Text(
          updatedAt,
          style: _captionTextStyle(context),
        )
      ];
    }
  }

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
                  user.nickName,
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
          Row(
            children: _buildSubtitleComponents(
                context: context,
                actionName: user.actionName,
                updatedAt: user.updatedAt,
                score: this.score),
          )
        ],
      ),
    );
  }
}
