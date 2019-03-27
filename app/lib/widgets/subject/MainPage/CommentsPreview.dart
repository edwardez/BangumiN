import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/subject/Subject.dart';
import 'package:munin/models/Bangumi/subject/comment/SubjectComment.dart';
import 'package:munin/shared/utils/collections/common.dart';
import 'package:munin/styles/theme/common.dart';
import 'package:munin/widgets/shared/icons/PlatformIcons.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';
import 'package:munin/widgets/subject/common/SubjectCommentWidget.dart';

class CommentsPreview extends StatelessWidget {
  final Subject subject;

  const CommentsPreview({Key key, @required this.subject}) : super(key: key);

  _moreCommentsButton(BuildContext context) {
    return IconButton(
      icon: Icon(PlatformIcons.forwardIconData),
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
          '短评',
          fit: FlexFit.tight,
        ),
        _moreCommentsButton(context),
      ],
    ));
    if (isIterableNullOrEmpty(subject.commentsPreview)) {
      commentPreviewWidgets.add(Center(
        child: Text(
          '暂无短评',
          style: captionTextWithBody1Size(context),
        ),
      ));
    } else {
      for (SubjectComment comment in subject.commentsPreview) {
        commentPreviewWidgets.add(SubjectCommentWidget(
          subjectComment: comment,
        ));
      }
    }
    return Column(
      children: commentPreviewWidgets,
    );
  }
}
