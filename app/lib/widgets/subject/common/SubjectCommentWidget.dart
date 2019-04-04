import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/subject/comment/SubjectComment.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';
import 'package:munin/widgets/subject/common/CommentUserListTile.dart';

class SubjectCommentWidget extends StatelessWidget {
  final commentMaxLines = 20;
  final SubjectComment subjectComment;

  const SubjectCommentWidget({Key key, @required this.subjectComment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CommentUserListTile(
          metaInfo: subjectComment.metaInfo,
        ),
        WrappableText(
          subjectComment.content,
          outerWrapper: OuterWrapper.Row,
          maxLines: commentMaxLines,
        )
      ],
    );
  }
}
