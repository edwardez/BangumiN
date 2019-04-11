import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/subject/comment/SubjectReview.dart';
import 'package:munin/shared/utils/time/TimeUtils.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/TimelineUserListTile.dart';
import 'package:munin/widgets/shared/avatar/CachedCircleAvatar.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';

class SubjectReviewWidget extends StatelessWidget {
  static const commentMaxLines = 20;
  static const avatarTextPadding = 8.0;
  static const outerVerticalPadding = 8.0;
  final SubjectReview subjectReview;
  final TimeDisplayFormat timeDisplayFormat;

  const SubjectReviewWidget({
    Key key,
    @required this.subjectReview,
    this.timeDisplayFormat = TimeDisplayFormat.AlwaysRelative,
  }) : super(key: key);

  _buildTextWidgets() {
    List<Widget> widgets = [];
    widgets.add(TimelineUserListTile(
      nickName: subjectReview.metaInfo.nickName,
      updatedAt: subjectReview.metaInfo.updatedAt,
      actionName: subjectReview.metaInfo.actionName,
      score: subjectReview.metaInfo.score,
      timeDisplayFormat: timeDisplayFormat,
    ));
    if (subjectReview.content != null) {
      widgets.add(WrappableText(
        subjectReview.content ?? '',
        outerWrapper: OuterWrapper.Row,
        maxLines: commentMaxLines,
      ));
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: outerVerticalPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CachedCircleAvatar(
            imageUrl: subjectReview.metaInfo.images.medium,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: avatarTextPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildTextWidgets(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
