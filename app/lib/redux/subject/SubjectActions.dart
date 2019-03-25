import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/Bangumi/subject/Subject.dart';

class GetSubjectAction {
  final BuildContext context;
  final int subjectId;

  GetSubjectAction({
    @required this.context,
    @required this.subjectId,
  });
}

class GetSubjectSuccessAction {
  final Subject subject;

  GetSubjectSuccessAction(this.subject);
}
