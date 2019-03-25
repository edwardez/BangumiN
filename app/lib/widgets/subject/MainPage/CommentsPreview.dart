import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/subject/Subject.dart';
import 'package:munin/models/Bangumi/subject/comment/SubjectComment.dart';
import 'package:munin/shared/utils/collections/common.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';
import 'package:munin/widgets/subject/common/SubjectCommentWidget.dart';

class CommentsPreview extends StatelessWidget {
  final Subject subject;

  const CommentsPreview({Key key, @required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> commentPreviewWidgets = [];

    if (isIterableNullOrEmpty(subject.commentsPreview)) {
      commentPreviewWidgets.add(Row(
        children: <Widget>[
          WrappableText(
            '短评',
            fit: FlexFit.tight,
          ),
        ],
      ));
      commentPreviewWidgets.add(Center(
        child: Text('暂无评价'),
      ));
    } else {
      commentPreviewWidgets.add(Row(
        children: <Widget>[
          WrappableText(
            '短评',
            fit: FlexFit.tight,
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
        ],
      ));

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
