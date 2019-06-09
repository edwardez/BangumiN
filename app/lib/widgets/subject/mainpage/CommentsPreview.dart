import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/review/SubjectReview.dart';
import 'package:munin/shared/utils/collections/common.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/subject/common/SubjectReviewWidget.dart';
import 'package:munin/widgets/subject/mainpage/SubjectMoreItemsEntry.dart';

class CommentsPreview extends StatelessWidget {
  final BangumiSubject subject;

  const CommentsPreview({Key key, @required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> commentPreviewWidgets = [];

    commentPreviewWidgets.add(
      SubjectMoreItemsEntry(
        moreItemsText: '最近收藏',
        onTap: () {},
      ),
    );

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
