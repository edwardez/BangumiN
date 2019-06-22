import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/widgets/subject/common/HorizontalRelatedSubjects.dart';
import 'package:munin/widgets/subject/mainpage/SubjectMoreItemsEntry.dart';

class RelatedSubjectsPreview extends StatelessWidget {
  final BangumiSubject subject;

  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;

  const RelatedSubjectsPreview(
      {Key key,
      @required this.subject,
      @required this.preferredSubjectInfoLanguage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SubjectMoreItemsEntry(
          moreItemsText: '关联条目',
          onTap: () {},
        ),
        HorizontalRelatedSubjects(
          relatedSubjects: subject.relatedSubjects,
          preferredSubjectInfoLanguage: preferredSubjectInfoLanguage,
        )
      ],
    );
  }
}
