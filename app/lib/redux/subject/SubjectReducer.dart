import 'package:built_collection/built_collection.dart';
import 'package:munin/models/bangumi/collection/SubjectCollectionInfo.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/review/SubjectReview.dart';
import 'package:munin/models/bangumi/subject/review/SubjectReviewResponse.dart';
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

  /// Reviews
  TypedReducer<SubjectState, GetSubjectReviewSuccessAction>(
      getSubjectReviewSuccessReducer),
]);

/// Subject Actions
SubjectState getSubjectLoadingReducer(SubjectState subjectState,
    GetSubjectLoadingAction getSubjectLoadingAction) {
  return subjectState.rebuild((b) => b
    ..subjectsLoadingStatus
        .addAll({getSubjectLoadingAction.subjectId: LoadingStatus.Loading}));
}

SubjectState getSubjectSuccessReducer(SubjectState subjectState, GetSubjectSuccessAction getSubjectSuccess) {
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
    GetCollectionInfoSuccessAction action) {
  SubjectCollectionInfo collectionInfo = action.collectionInfo;

  BangumiSubject subject = action.bangumiSubject;

  subjectState = subjectState.rebuild((b) =>
  b
    ..collections.addAll(
      {action.subjectId: collectionInfo},
    )
    ..collectionsLoadingStatus.addAll(
      {action.subjectId: LoadingStatus.Success},
    ));

  if (subject != null) {
    subjectState = subjectState
        .rebuild((b) => b..subjects.addAll({action.subjectId: subject}));
  }

  return subjectState;
}

SubjectState getCollectionInfoFailureReducer(SubjectState subjectState,
    GetCollectionInfoFailureAction getCollectionInfoFailureAction) {
  return subjectState.rebuild((b) => b
    ..collectionsLoadingStatus.addAll({
      getCollectionInfoFailureAction.subjectId:
      getCollectionInfoFailureAction.loadingStatus
    }));
}

/// Removes all collection-related info for this subject from store
SubjectState collectionInfoCleanUpReducer(SubjectState subjectState,
    CleanUpCollectionInfoAction cleanUpCollectionInfoAction) {
  return subjectState.rebuild((b) => b
    ..collectionsLoadingStatus.remove(cleanUpCollectionInfoAction.subjectId)
    ..collectionsSubmissionStatus.remove(cleanUpCollectionInfoAction.subjectId)
    ..collections.remove(cleanUpCollectionInfoAction.subjectId));
}

/// Update Collection Actions

SubjectState updateCollectionInfoSuccessReducer(SubjectState subjectState,
    UpdateCollectionRequestSuccessAction action) {
  /// Update collection info.
  subjectState = subjectState.rebuild((b) =>
  b
    ..collections.remove(action.subjectId)
    ..collectionsSubmissionStatus.addAll(
      {action.subjectId: LoadingStatus.Success},
    ));

  if (subjectState.subjects[action.subjectId] != null) {
    var subjectToUpdate = subjectState.subjects[action.subjectId];
    subjectToUpdate = subjectToUpdate
        .rebuild((b) =>
        b.userSubjectCollectionInfoPreview.replace(
          subjectToUpdate.userSubjectCollectionInfoPreview.rebuild(
                (b) =>
            b
              ..score = action.collectionUpdateResponse.rating
              ..status = action.collectionUpdateResponse.status.type,
          ),
        ));
    subjectState = subjectState.rebuild((b) =>
    b
      ..subjects.addAll(
        {action.subjectId: subjectToUpdate},
      ));
  }

  return subjectState;
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

/// Reviews
SubjectState getSubjectReviewSuccessReducer(SubjectState subjectState,
    GetSubjectReviewSuccessAction action) {
  if (!action.parsedSubjectReviews.isRequestedPageNumberValid) {
    return subjectState;
  }

  SubjectReviewResponse responseInStore =
  subjectState.subjectsReviews[action.getSubjectReviewRequest];
  if (responseInStore != null) {
    responseInStore = responseInStore.rebuild((b) =>
    b
      ..items.addAll(action.parsedSubjectReviews.reviewItems)
      ..canLoadMoreItems = action.parsedSubjectReviews.canLoadMoreItems ?? true
      ..requestedUntilPageNumber += 1);
  } else {
    responseInStore = SubjectReviewResponse((b) =>
    b
      ..items.replace(
        BuiltMap<String, SubjectReview>.of(
            action.parsedSubjectReviews.reviewItems),
      )
      ..canLoadMoreItems = action.parsedSubjectReviews.canLoadMoreItems ?? true
      ..requestedUntilPageNumber = 1
    );
  }

  return subjectState.rebuild((b) =>
  b
    ..subjectsReviews
        .addAll({action.getSubjectReviewRequest: responseInStore}));
}
