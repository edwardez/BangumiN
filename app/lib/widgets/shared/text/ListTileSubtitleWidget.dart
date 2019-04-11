import 'package:flutter/material.dart';
import 'package:munin/shared/utils/time/TimeUtils.dart';
import 'package:munin/widgets/shared/common/SubjectStars.dart';
import 'package:munin/widgets/shared/utils/ExpandedEmpty.dart';

/// a subtitle for list tile that contains an action, a subject score and a updatedAt time
/// it's used in timeline, user comment lists...etc
/// this widget assumes actionName will never be null or empty
class ListTileSubtitleWidget extends StatelessWidget {
  final String actionName;
  final int updatedAt;
  final TimeDisplayFormat timeDisplayFormat;
  final double score;

  ListTileSubtitleWidget(
      {@required this.actionName, @required this.updatedAt, this.score,
        this.timeDisplayFormat = TimeDisplayFormat.AlwaysRelative,
      });

  @override
  Widget build(BuildContext context) {
    TextStyle captionStyle = Theme
        .of(context)
        .textTheme
        .caption;

    if (score == null) {
      return Row(
        children: [
          Expanded(
              child: Text(
                actionName,

                /// action should be at most 1 line, this is currently hard-coded and forced for aesthetic reason
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: captionStyle,
              )),
          Text(
            TimeUtils.formatMilliSecondsEpochTime(
                updatedAt, timeDisplayFormat: timeDisplayFormat),
            style: captionStyle,
          )
        ],
      );
    } else {
      /// if text overflows there will be an error
      /// however length of this text is predictable so it should be fine
      return Row(
        children: [
          Text(
            actionName,
            style: captionStyle,
          ),
          SubjectStars(
            subjectScore: score,
          ),
          ExpandedEmpty(),
          Text(
            TimeUtils.formatMilliSecondsEpochTime(
                updatedAt, timeDisplayFormat: timeDisplayFormat),
            style: captionStyle,
          )
        ],
      );
    }
  }
}
