import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/comment/SubjectReview.dart';
import 'package:munin/shared/utils/collections/common.dart';
import 'package:munin/styles/theme/common.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';
import 'package:munin/widgets/subject/common/SubjectReviewWidget.dart';

class CommentsPreview extends StatelessWidget {
  final BangumiSubject subject;

  const CommentsPreview({Key key, @required this.subject}) : super(key: key);

  _moreCommentsButton(BuildContext context) {
    return IconButton(
      icon: Icon(AdaptiveIcons.forwardIconData),
      color: Theme
          .of(context)
          .primaryColor,
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> commentPreviewWidgets = [];

    commentPreviewWidgets.add(Row(
      children: <Widget>[
        WrappableText(
          '最近收藏',
          fit: FlexFit.tight,
        ),
        _moreCommentsButton(context),
      ],
    ));
    if (isIterableNullOrEmpty(subject.commentsPreview)) {
      commentPreviewWidgets.add(Center(
        child: Text(
          '暂无用户收藏',
          style: captionTextWithBody1Size(context),
        ),
      ));
    } else {
      for (SubjectReview review in subject.commentsPreview) {
        commentPreviewWidgets.add(SubjectReviewWidget(
          subject: subject,
          review: review,
        ));
      }
    }
    return Column(
      children: commentPreviewWidgets,
    );
  }
}
