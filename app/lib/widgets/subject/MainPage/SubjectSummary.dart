import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/Bangumi/subject/BangumiSubject.dart';
import 'package:munin/router/routes.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';

class SubjectSummary extends StatelessWidget {
  final BangumiSubject subject;
  final int summaryMaxLines = 5;

  const SubjectSummary({Key key, @required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            WrappableText.mediumVerticalPadding(
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
                onPressed: () {
                  /// opens [SubjectDetailInfoWidget]
                  Application.router.navigateTo(
                      context,
                      Routes.subjectDetailInfoPageRoute
                          .replaceFirst(':subjectId', subject.id?.toString()),
                      transition: TransitionType.native);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
