import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/collection/SubjectCollectionInfo.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/review/GetSubjectReviewRequest.dart';
import 'package:munin/providers/bangumi/subject/parser/SubjectReviewParser.dart';

class GetSubjectAction {
  final int subjectId;
  final Completer<void> completer;

  GetSubjectAction({
    @required this.subjectId,
    Completer completer,
  }) : this.completer = completer ?? Completer();
}

class GetSubjectSuccessAction {
  final BangumiSubject subject;

  const GetSubjectSuccessAction(this.subject);
}

class GetCollectionInfoAction {
  final int subjectId;
  final Completer completer;

  GetCollectionInfoAction({
    @required this.subjectId,
    Completer completer,
  }) : this.completer = completer ?? Completer();
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

class CleanUpCollectionInfoAction {
  final int subjectId;

  const CleanUpCollectionInfoAction({
    @required this.subjectId,
  });
}

class UpdateCollectionRequestAction {
  final int subjectId;
  final SubjectCollectionInfo collectionUpdateRequest;
  final Completer completer;

  UpdateCollectionRequestAction({
    @required this.subjectId,
    @required this.collectionUpdateRequest,
    Completer completer,
  }) : this.completer = completer ?? Completer();
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
