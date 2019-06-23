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
  final DisplayTimeIn timeDisplayFormat;

  /// see [AbsoluteTimeFormat]
  /// This won't work if time is displayed in relative format
  final AbsoluteTimeFormat formatAbsoluteTimeAs;
  final double score;

  static const double starCaptionFontSizeRatio = 1.2;

  const ListTileSubtitleWidget({
    @required this.actionName,
    @required this.updatedAt,
    this.score,
    this.timeDisplayFormat = DisplayTimeIn.AlwaysRelative,
    this.formatAbsoluteTimeAs,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle captionStyle = Theme.of(context).textTheme.caption;

    if (score == null) {
      return Row(
        children: [
          Expanded(
              child: Text(
            actionName,

            // Action should be at most 1 line, this is currently hard-coded and forced for aesthetic reason
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: captionStyle,
          )),
          Text(
            TimeUtils.formatMilliSecondsEpochTime(
              updatedAt,
              displayTimeIn: timeDisplayFormat,
              formatAbsoluteTimeAs: formatAbsoluteTimeAs,
            ),
            style: captionStyle,
          )
        ],
      );
    } else {
      // If text overflows there will be an error
      // however length of this text is predictable so it should be fine
      return Row(
        children: [
          Text(
            actionName,
            style: captionStyle,
          ),
          SubjectStars(
            subjectScore: score,
            starSize: captionStyle.fontSize * starCaptionFontSizeRatio,
          ),
          ExpandedEmpty(),
          Text(
            TimeUtils.formatMilliSecondsEpochTime(
              updatedAt,
              displayTimeIn: timeDisplayFormat,
              formatAbsoluteTimeAs: formatAbsoluteTimeAs,
            ),
            style: captionStyle,
          )
        ],
      );
    }
  }
}
