import 'package:munin/models/bangumi/collection/SubjectCollectionInfo.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';
import 'package:munin/redux/subject/SubjectActions.dart';
import 'package:munin/redux/subject/SubjectState.dart';
import 'package:redux/redux.dart';

final subjectReducers = combineReducers<SubjectState>([
  /// Subject
  TypedReducer<SubjectState, GetSubjectLoadingAction>(getSubjectLoadingReducer),
  TypedReducer<SubjectState, GetSubjectSuccessAction>(getSubjectSuccessReducer),
  TypedReducer<SubjectState, GetSubjectFailureAction>(getSubjectFailureReducer),
  TypedReducer<SubjectState, CleanUpLoadingStatusAction>(
      cleanUpLoadingStatusReducer),

  /// Collections
  TypedReducer<SubjectState, GetCollectionInfoLoadingAction>(
      getCollectionInfoLoadingReducer),
  TypedReducer<SubjectState, GetCollectionInfoFailureAction>(
      getCollectionInfoFailureReducer),
  TypedReducer<SubjectState, CleanUpCollectionInfoAction>(
      collectionInfoCleanUpReducer),
  TypedReducer<SubjectState, GetCollectionInfoSuccessAction>(
      getCollectionInfoSuccessReducer),

  /// Update collection
  TypedReducer<SubjectState, UpdateCollectionRequestSuccessAction>(
      updateCollectionInfoSuccessReducer),
  TypedReducer<SubjectState, UpdateCollectionRequestFailureAction>(
      updateCollectionRequestFailureReducer),
  TypedReducer<SubjectState, UpdateCollectionRequestLoadingAction>(
      updateCollectionRequestLoadingReducer),
]);

/// Subject Actions
SubjectState getSubjectLoadingReducer(SubjectState subjectState,
    GetSubjectLoadingAction getSubjectLoadingAction) {
  return subjectState.rebuild((b) => b
    ..subjectsLoadingStatus
        .addAll({getSubjectLoadingAction.subjectId: LoadingStatus.Loading}));
}

SubjectState getSubjectSuccessReducer(
    SubjectState subjectState, GetSubjectSuccessAction getSubjectSuccess) {
  BangumiSubject subject = getSubjectSuccess.subject;
  return subjectState.rebuild((b) => b
    ..subjects.addAll({subject.id: subject})
    ..subjectsLoadingStatus.addAll({subject.id: LoadingStatus.Success}));
}

SubjectState getSubjectFailureReducer(SubjectState subjectState,
    GetSubjectFailureAction getSubjectFailureAction) {
  return subjectState.rebuild((b) => b
    ..subjectsLoadingStatus.addAll({
      getSubjectFailureAction.subjectId: getSubjectFailureAction.loadingStatus
    }));
}

SubjectState cleanUpLoadingStatusReducer(SubjectState subjectState,
    CleanUpLoadingStatusAction cleanUpLoadingStatusAction) {
  return subjectState.rebuild((b) =>
      b..subjectsLoadingStatus.remove(cleanUpLoadingStatusAction.subjectId));
}

/// Get Collection Actions
SubjectState getCollectionInfoLoadingReducer(SubjectState subjectState,
    GetCollectionInfoLoadingAction getCollectionInfoLoadingAction) {
  return subjectState.rebuild((b) => b
    ..collectionsLoadingStatus.addAll(
        {getCollectionInfoLoadingAction.subjectId: LoadingStatus.Loading}));
}

SubjectState getCollectionInfoSuccessReducer(SubjectState subjectState,
    GetCollectionInfoSuccessAction getCollectionInfoSuccessAction) {
  SubjectCollectionInfo collectionInfo =
      getCollectionInfoSuccessAction.collectionInfo;

  return subjectState.rebuild((b) => b
    ..collections
        .addAll({getCollectionInfoSuccessAction.subjectId: collectionInfo})
    ..collectionsLoadingStatus.addAll(
        {getCollectionInfoSuccessAction.subjectId: LoadingStatus.Success}));
}

SubjectState getCollectionInfoFailureReducer(SubjectState subjectState,
    GetCollectionInfoFailureAction getCollectionInfoFailureAction) {
  return subjectState.rebuild((b) => b
    ..collectionsLoadingStatus.addAll({
      getCollectionInfoFailureAction.subjectId:
          getCollectionInfoFailureAction.loadingStatus
    }));
}

/// Remove all collection-related info for this subject from store
SubjectState collectionInfoCleanUpReducer(SubjectState subjectState,
    CleanUpCollectionInfoAction cleanUpCollectionInfoAction) {
  return subjectState.rebuild((b) => b
    ..collectionsLoadingStatus.remove(cleanUpCollectionInfoAction.subjectId)
    ..collectionsSubmissionStatus.remove(cleanUpCollectionInfoAction.subjectId)
    ..collections.remove(cleanUpCollectionInfoAction.subjectId));
}

/// Update Collection Actions

SubjectState updateCollectionInfoSuccessReducer(SubjectState subjectState,
    UpdateCollectionRequestSuccessAction collectionUpdateRequestSuccessAction) {
  return subjectState.rebuild((b) => b
    ..collections.remove(collectionUpdateRequestSuccessAction.subjectId)
    ..collectionsSubmissionStatus.addAll({
      collectionUpdateRequestSuccessAction.subjectId: LoadingStatus.Success
    }));
}

SubjectState updateCollectionRequestLoadingReducer(SubjectState subjectState,
    UpdateCollectionRequestLoadingAction collectionUpdateRequestSuccessAction) {
  return subjectState.rebuild((b) => b
    ..collectionsSubmissionStatus.addAll({
      collectionUpdateRequestSuccessAction.subjectId: LoadingStatus.Loading
    }));
}

SubjectState updateCollectionRequestFailureReducer(SubjectState subjectState,
    UpdateCollectionRequestFailureAction updateCollectionRequestFailureAction) {
  return subjectState.rebuild((b) => b
    ..collectionsSubmissionStatus.addAll({
      updateCollectionRequestFailureAction.subjectId:
          updateCollectionRequestFailureAction.loadingStatus
    }));
}
