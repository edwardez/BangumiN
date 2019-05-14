import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/comment/SubjectReview.dart';
import 'package:munin/shared/utils/time/TimeUtils.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/TimelineUserListTile.dart';
import 'package:munin/widgets/shared/avatar/CachedCircleAvatar.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';
import 'package:munin/widgets/subject/share/common.dart';

class SubjectReviewWidget extends StatelessWidget {
  static const commentMaxLines = 20;
  static const avatarTextPadding = 8.0;
  static const outerVerticalPadding = 8.0;

  final BangumiSubject subject;
  final SubjectReview review;
  final DisplayTimeIn timeDisplayFormat;

  const SubjectReviewWidget({
    Key key,
    @required this.review,
    @required this.subject,
    this.timeDisplayFormat = DisplayTimeIn.AlwaysRelative,
  }) : super(key: key);

  _buildTextWidgets(BuildContext context) {
    Icon moreActionsIcon = Icon(
      AdaptiveIcons.moreActionsIconData,
      size: smallerIconSize,
      color: Theme
          .of(context)
          .textTheme
          .caption
          .color,
    );


    Widget trailing = InkWell(
        child: moreActionsIcon,
        onTap: () {
          showMoreActionsForReview(
              subject: subject,
              context: context,
              review: review
          );
        },
        borderRadius: BorderRadius.circular(defaultIconSize)
    );
    List<Widget> widgets = [];
    widgets.add(TimelineUserListTile(
      nickName: review.metaInfo.nickName,
      updatedAt: review.metaInfo.updatedAt,
      trailing: trailing,
      actionName: review.metaInfo.actionName,
      score: review.metaInfo.score,
      timeDisplayFormat: timeDisplayFormat,
    ));
    if (review.content != null) {
      widgets.add(WrappableText(
        review.content ?? '',
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
            imageUrl: review.metaInfo.userAvatars.medium,
              navigateToUserRouteOnTap: true,
              username: review.metaInfo.username
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: avatarTextPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildTextWidgets(context),
              ),
            ),
          )
        ],
      ),
    );
  }
}
