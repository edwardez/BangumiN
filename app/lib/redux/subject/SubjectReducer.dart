import 'package:built_collection/built_collection.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/collection/SubjectCollectionInfo.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/review/SubjectReview.dart';
import 'package:munin/models/bangumi/subject/review/SubjectReviewResponse.dart';
import 'package:munin/redux/subject/SubjectActions.dart';
import 'package:munin/redux/subject/SubjectState.dart';
import 'package:redux/redux.dart';

final subjectReducers = combineReducers<SubjectState>([

  /// Subject
  TypedReducer<SubjectState, GetSubjectSuccessAction>(getSubjectSuccessReducer),

  /// Collections
  TypedReducer<SubjectState, CleanUpCollectionInfoAction>(
      collectionInfoCleanUpReducer),
  TypedReducer<SubjectState, GetCollectionInfoSuccessAction>(
      getCollectionInfoSuccessReducer),

  /// Update collection
  TypedReducer<SubjectState, UpdateCollectionRequestSuccessAction>(
      updateCollectionInfoSuccessReducer),
  TypedReducer<SubjectState, DeleteCollectionRequestSuccessAction>(
      deleteCollectionRequestSuccessReducer),

  /// Reviews
  TypedReducer<SubjectState, GetSubjectReviewSuccessAction>(
      getSubjectReviewSuccessReducer),
]);

/// Subject Actions
SubjectState getSubjectSuccessReducer(SubjectState subjectState, GetSubjectSuccessAction getSubjectSuccess) {
  BangumiSubject subject = getSubjectSuccess.subject;
  return subjectState.rebuild((b) => b
    ..subjects.addAll({subject.id: subject})
  );
}

/// Get Collection Actions
SubjectState getCollectionInfoSuccessReducer(SubjectState subjectState,
    GetCollectionInfoSuccessAction action) {
  SubjectCollectionInfo collectionInfo = action.collectionInfo;

  BangumiSubject subject = action.bangumiSubject;

  subjectState = subjectState.rebuild((b) =>
  b
    ..collections.addAll(
      {action.subjectId: collectionInfo},
    )
  );

  if (subject != null) {
    subjectState = subjectState
        .rebuild((b) => b..subjects.addAll({action.subjectId: subject}));
  }

  return subjectState;
}

/// Removes all collection-related info for this subject from store
SubjectState collectionInfoCleanUpReducer(SubjectState subjectState,
    CleanUpCollectionInfoAction cleanUpCollectionInfoAction) {
  return subjectState.rebuild((b) => b
    ..collections.remove(cleanUpCollectionInfoAction.subjectId));
}

/// Update Collection Actions

SubjectState updateCollectionInfoSuccessReducer(SubjectState subjectState,
    UpdateCollectionRequestSuccessAction action) {
  /// Update collection info.
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

SubjectState deleteCollectionRequestSuccessReducer(SubjectState subjectState,
    DeleteCollectionRequestSuccessAction action) {
  final int subjectId = action.subjectId;

  /// Update collection info.
  var subjectToUpdate = subjectState.subjects[subjectId];
  if (subjectToUpdate != null) {
    subjectToUpdate = subjectToUpdate
        .rebuild((b) =>
        b.userSubjectCollectionInfoPreview.replace(
          subjectToUpdate.userSubjectCollectionInfoPreview.rebuild(
                (b) =>
            b
              ..score = 0
              ..status = CollectionStatus.Pristine,
          ),
        ));
    subjectState = subjectState.rebuild((b) =>
    b
      ..subjects.addAll(
        {subjectId: subjectToUpdate},
      ));
  }

  var collectionToUpdate = subjectState.collections[subjectId];
  if (collectionToUpdate != null) {
    subjectState = subjectState.rebuild((b) =>
    b
      ..collections.addAll(
        {subjectId: SubjectCollectionInfo()},
      ));
  }

  return subjectState;
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
