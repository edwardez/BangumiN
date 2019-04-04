import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/UnknownTimelineActivity.dart';
import 'package:munin/shared/utils/common.dart';

/// an unknown timeline activity, only truncated plain text will be shown
class UnknownTimelineActivityWidget extends StatelessWidget {
  final UnknownTimelineActivity unknownTimelineActivity;

  final int maxUnknownTimelineActivityLength = 500;

  const UnknownTimelineActivityWidget(
      {Key key, @required this.unknownTimelineActivity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Text(truncateStringTo(unknownTimelineActivity.content,
              maxUnknownTimelineActivityLength)),
        )
      ],
    );
  }
}
