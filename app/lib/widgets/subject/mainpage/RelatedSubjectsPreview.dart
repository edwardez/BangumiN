import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/models/bangumi/subject/RelatedSubject.dart';
import 'package:munin/widgets/subject/common/HorizontalRelatedSubjects.dart';
import 'package:munin/widgets/subject/mainpage/SubjectMoreItemsEntry.dart';

class RelatedSubjectsPreview extends StatelessWidget {
  final BuiltListMultimap<String, RelatedSubject> relatedSubjects;

  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;

  const RelatedSubjectsPreview({Key key,
    @required this.relatedSubjects,
    @required this.preferredSubjectInfoLanguage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SubjectMoreItemsEntry(
          moreItemsText: '关联条目',
        ),
        HorizontalRelatedSubjects(
          relatedSubjects: relatedSubjects.values,
          preferredSubjectInfoLanguage: preferredSubjectInfoLanguage,
        ),
      ],
    );
  }
}
