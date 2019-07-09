import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/models/bangumi/subject/RelatedSubject.dart';
import 'package:munin/widgets/subject/common/HorizontalRelatedSubjects.dart';
import 'package:munin/widgets/subject/mainpage/SubjectMoreItemsEntry.dart';

class TankobonSubjectsPreview extends StatelessWidget {
  final BuiltList<RelatedSubject> tankobonSubjects;

  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;

  const TankobonSubjectsPreview(
      {Key key,
      @required this.tankobonSubjects,
      @required this.preferredSubjectInfoLanguage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SubjectMoreItemsEntry(
          moreItemsText: '单行本',
        ),
        HorizontalRelatedSubjects(
          relatedSubjects: tankobonSubjects,
          preferredSubjectInfoLanguage: preferredSubjectInfoLanguage,

          /// All tankobons share a same subtitle('单行本') hence no need
          /// to display subtitle.
          displaySubtitle: false,
        ),
      ],
    );
  }
}
