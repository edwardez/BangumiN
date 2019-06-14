import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/collection/SubjectCollectionInfo.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/review/GetSubjectReviewRequest.dart';
import 'package:munin/providers/bangumi/subject/parser/SubjectReviewParser.dart';
import 'package:munin/redux/shared/CommonActions.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';

class GetSubjectAction {
  final BuildContext context;
  final int subjectId;

  const GetSubjectAction({
    @required this.context,
    @required this.subjectId,
  });
}

class GetSubjectLoadingAction {
  final int subjectId;

  const GetSubjectLoadingAction({
    @required this.subjectId,
  });
}

class GetSubjectSuccessAction {
  final BangumiSubject subject;

  const GetSubjectSuccessAction(this.subject);
}

class GetSubjectFailureAction extends FailureAction {
  int subjectId;

  GetSubjectFailureAction(
      {@required this.subjectId, @required LoadingStatus loadingStatus})
      : super(loadingStatus: loadingStatus);

  GetSubjectFailureAction.fromUnknownException({@required this.subjectId})
      : super.fromUnknownException();
}

class CleanUpLoadingStatusAction {
  final int subjectId;

  const CleanUpLoadingStatusAction({
    @required this.subjectId,
  });
}

class GetCollectionInfoAction {
  final BuildContext context;
  final int subjectId;
  final Completer completer;

  GetCollectionInfoAction({
    @required this.context,
    @required this.subjectId,
    Completer completer,
  }) : this.completer = completer ?? new Completer();
}

class GetCollectionInfoLoadingAction {
  final int subjectId;

  const GetCollectionInfoLoadingAction({
    @required this.subjectId,
  });
}

class GetCollectionInfoSuccessAction {
  final int subjectId;
  final SubjectCollectionInfo collectionInfo;
  final BangumiSubject bangumiSubject;

  const GetCollectionInfoSuccessAction({
    @required this.subjectId,
    @required this.collectionInfo,
    this.bangumiSubject,
  });
}

class GetCollectionInfoFailureAction extends FailureAction {
  final int subjectId;

  const GetCollectionInfoFailureAction(
      {@required this.subjectId, @required LoadingStatus loadingStatus})
      : super(loadingStatus: loadingStatus);

  const GetCollectionInfoFailureAction.fromUnknownException(
      {@required this.subjectId})
      : super.fromUnknownException();
}

class CleanUpCollectionInfoAction {
  final int subjectId;

  const CleanUpCollectionInfoAction({
    @required this.subjectId,
  });
}

class UpdateCollectionRequestAction {
  final BuildContext context;
  final int subjectId;
  final SubjectCollectionInfo collectionUpdateRequest;

  const UpdateCollectionRequestAction({@required this.context,
    @required this.subjectId,
    @required this.collectionUpdateRequest});
}

class UpdateCollectionRequestLoadingAction {
  final int subjectId;

  const UpdateCollectionRequestLoadingAction({@required this.subjectId});
}

class UpdateCollectionRequestFailureAction extends FailureAction {
  final int subjectId;

  const UpdateCollectionRequestFailureAction({
    @required this.subjectId,
    @required LoadingStatus loadingStatus,
  }) : super(loadingStatus: loadingStatus);

  const UpdateCollectionRequestFailureAction.fromUnknownException(
      {@required this.subjectId})
      : super.fromUnknownException();
}

class UpdateCollectionRequestSuccessAction {
  final int subjectId;
  final SubjectCollectionInfo collectionUpdateResponse;

  const UpdateCollectionRequestSuccessAction(
      {@required this.subjectId, this.collectionUpdateResponse});
}

/// Reviews
class GetSubjectReviewAction {
  final GetSubjectReviewRequest getSubjectReviewRequest;
  final BuildContext context;
  final Completer completer;

  GetSubjectReviewAction({
    @required this.getSubjectReviewRequest,
    @required this.context,
    Completer completer,
  }) : this.completer = completer ?? new Completer();
}

class GetSubjectReviewSuccessAction {
  final GetSubjectReviewRequest getSubjectReviewRequest;
  final ParsedSubjectReviews parsedSubjectReviews;

  const GetSubjectReviewSuccessAction({
    @required this.getSubjectReviewRequest,
    @required this.parsedSubjectReviews,
  });
}
