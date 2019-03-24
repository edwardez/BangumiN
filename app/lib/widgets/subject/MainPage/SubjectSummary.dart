import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/subject/Subject.dart';
import 'package:munin/widgets/shared/text/ClippedText.dart';

class SubjectSummary extends StatelessWidget {
  final Subject subject;
  final int summaryMaxLines = 5;

  const SubjectSummary({Key key, @required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            ClippedText.mediumVerticalPadding(
              subject.summary,
              maxLines: summaryMaxLines,
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: FlatButton(
                child: Text('简介与制作人员'),
                textColor: Theme.of(context).primaryColor,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
