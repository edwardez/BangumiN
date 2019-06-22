import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionRequest.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionResponse.dart';
import 'package:munin/models/bangumi/discussion/thread/common/BangumiThread.dart';
import 'package:munin/models/bangumi/discussion/thread/common/GetThreadRequest.dart';

class GetDiscussionRequestAction {
  final BuildContext context;
  final GetDiscussionRequest getDiscussionRequest;
  final Completer completer;

  GetDiscussionRequestAction({
    @required this.context,
    @required this.getDiscussionRequest,
    Completer completer,
  }) : this.completer = completer ?? Completer();
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
  final GetThreadRequest request;
  final Completer completer;
  final Color captionTextColor;

  GetThreadRequestAction({
    @required this.request,
    @required this.captionTextColor,
    Completer completer,
  }) : this.completer = completer ?? Completer();
}

class GetThreadRequestSuccessAction {
  final GetThreadRequest request;
  final BangumiThread thread;

  const GetThreadRequestSuccessAction({
    @required this.thread,
    @required this.request,
  });
}
