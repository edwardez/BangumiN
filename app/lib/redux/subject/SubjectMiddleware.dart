import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/subject/Subject.dart';
import 'package:munin/providers/bangumi/subject/BangumiSubjectService.dart';
import 'package:munin/providers/bangumi/subject/parser/SubjectParser.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/subject/SubjectActions.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createSubjectMiddleware(
    BangumiSubjectService bangumiSubjectService) {
  final getSubject = _createGetSubject(bangumiSubjectService);

  return [
    TypedMiddleware<AppState, GetSubjectAction>(getSubject),
  ];
}

Middleware<AppState> _createGetSubject(
    BangumiSubjectService bangumiSubjectService) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    try {
      if (action is GetSubjectAction) {
        var subjectHtml =
            await bangumiSubjectService.getSubject(subjectId: action.subjectId);
        Subject subject = SubjectParser().process(subjectHtml.data);
        store.dispatch(GetSubjectSuccessAction(subject));
      }
    } catch (error, stack) {
      print(error.toString());
      print(stack);
      Scaffold.of(action.context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    } finally {}

    next(action);
  };
}
