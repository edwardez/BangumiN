import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/collection/SubjectCollectionInfo.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/redux/shared/CommonActions.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';

class GetSubjectAction {
  final BuildContext context;
  final int subjectId;

  GetSubjectAction({
    @required this.context,
    @required this.subjectId,
  });
}

class GetSubjectLoadingAction {
  final int subjectId;

  GetSubjectLoadingAction({
    @required this.subjectId,
  });
}

class GetSubjectSuccessAction {
  final BangumiSubject subject;

  GetSubjectSuccessAction(this.subject);
}

class GetSubjectFailureAction extends FailureAction {
  int subjectId;

  GetSubjectFailureAction({@required this.subjectId, @required LoadingStatus loadingStatus})
      : super(loadingStatus: loadingStatus);

  GetSubjectFailureAction.fromUnknownException({@required this.subjectId})
      : super.fromUnknownException();
}

class CleanUpLoadingStatusAction {
  final int subjectId;

  CleanUpLoadingStatusAction({
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

  GetCollectionInfoLoadingAction({
    @required this.subjectId,
  });
}

class GetCollectionInfoSuccessAction {
  final int subjectId;
  final SubjectCollectionInfo collectionInfo;
  final BangumiSubject bangumiSubject;

  GetCollectionInfoSuccessAction({
    @required this.subjectId,
    @required this.collectionInfo,
    this.bangumiSubject,
  });
}

class GetCollectionInfoFailureAction extends FailureAction {
  final int subjectId;

  GetCollectionInfoFailureAction({@required this.subjectId, @required LoadingStatus loadingStatus})
      : super(loadingStatus: loadingStatus);

  GetCollectionInfoFailureAction.fromUnknownException({@required this.subjectId})
      : super.fromUnknownException();
}

class CleanUpCollectionInfoAction {
  final int subjectId;

  CleanUpCollectionInfoAction({
    @required this.subjectId,
  });
}

class UpdateCollectionRequestAction {
  final BuildContext context;
  final int subjectId;
  final SubjectCollectionInfo collectionUpdateRequest;

  UpdateCollectionRequestAction({@required this.context,
    @required this.subjectId,
    @required this.collectionUpdateRequest});
}

class UpdateCollectionRequestLoadingAction {
  final int subjectId;

  UpdateCollectionRequestLoadingAction({ @required this.subjectId});
}

class UpdateCollectionRequestFailureAction extends FailureAction {
  final int subjectId;

  UpdateCollectionRequestFailureAction({
    @required this.subjectId,
    @required LoadingStatus loadingStatus,
  }) : super(loadingStatus: loadingStatus);

  UpdateCollectionRequestFailureAction.fromUnknownException({@required this.subjectId})
      : super.fromUnknownException();
}

class UpdateCollectionRequestSuccessAction {
  final int subjectId;
  final SubjectCollectionInfo collectionUpdateResponse;

  UpdateCollectionRequestSuccessAction({@required this.subjectId, this.collectionUpdateResponse});
}
