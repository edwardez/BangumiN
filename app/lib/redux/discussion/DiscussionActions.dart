import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionRequest.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionResponse.dart';
import 'package:munin/models/bangumi/discussion/thread/common/BangumiThread.dart';
import 'package:munin/models/bangumi/discussion/thread/common/GetThreadRequest.dart';
import 'package:munin/redux/shared/CommonActions.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';

class GetDiscussionRequestAction {
  final BuildContext context;
  final GetDiscussionRequest getDiscussionRequest;
  final Completer completer;

  GetDiscussionRequestAction(
      {@required this.context,
        @required this.getDiscussionRequest,
      Completer completer})
      : this.completer = completer ?? new Completer();
}

class GetDiscussionRequestSuccessAction {
  final GetDiscussionRequest getDiscussionRequest;
  final GetDiscussionResponse getDiscussionResponse;

  const GetDiscussionRequestSuccessAction({
    @required this.getDiscussionRequest,
    @required this.getDiscussionResponse,
  });
}

class GetThreadRequestAction {
  final BuildContext context;
  final GetThreadRequest request;

  const GetThreadRequestAction({
    @required this.context,
    @required this.request,
  });
}

class GetThreadRequestFailureAction extends FailureAction {
  final GetThreadRequest request;

  const GetThreadRequestFailureAction({
    @required this.request,
    @required LoadingStatus loadingStatus,
  }) : super(loadingStatus: loadingStatus);

  const GetThreadRequestFailureAction.fromUnknownException(
      {@required this.request})
      : super.fromUnknownException();
}

class GetThreadRequestSuccessAction {
  final GetThreadRequest request;
  final BangumiThread thread;

  const GetThreadRequestSuccessAction({
    @required this.thread,
    @required this.request,
  });
}
