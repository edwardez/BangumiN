import 'package:flutter/material.dart';
import 'package:munin/widgets/shared/utils/ExpandedEmpty.dart';
import 'package:munin/widgets/shared/utils/SubjectStars.dart';

/// a subtitle for list tile that contains an action, a subject score and a updatedAt time
/// it's used in timeline, user comment lists...etc
/// this widget assumes actionName will never be null or empty
class ListTileSubtitleWidget extends StatelessWidget {
  final String actionName;
  final String updatedAt;
  final double score;

  ListTileSubtitleWidget(
      {@required this.actionName, @required this.updatedAt, this.score});

  @override
  Widget build(BuildContext context) {
    if (score == null) {
      return Row(
        children: [
          Expanded(
              child: Text(
            actionName,

            /// action should be at most 1 line, this is currently hard-coded and forced for aesthetic reason
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
          Text(
            updatedAt,
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
          ),
          SubjectStars(
            subjectScore: score,
          ),
          ExpandedEmpty(),
          Text(
            updatedAt,
          )
        ],
      );
    }
  }
}
