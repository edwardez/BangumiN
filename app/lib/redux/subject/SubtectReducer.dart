import 'package:munin/models/Bangumi/subject/Subject.dart';
import 'package:munin/redux/subject/SubjectActions.dart';
import 'package:munin/redux/subject/SubjectState.dart';
import 'package:redux/redux.dart';

final subjectReducers = combineReducers<SubjectState>([
  TypedReducer<SubjectState, GetSubjectSuccessAction>(
      loadSubjectSuccessReducer),
]);

SubjectState loadSubjectSuccessReducer(
    SubjectState subjectState, GetSubjectSuccessAction getSubjectSuccess) {
  Subject subject = getSubjectSuccess.subject;
  return subjectState.rebuild((b) => b..subjects.addAll({subject.id: subject}));
}
