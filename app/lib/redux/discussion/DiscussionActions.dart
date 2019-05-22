import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionRequest.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionResponse.dart';

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

  GetDiscussionRequestSuccessAction({@required this.getDiscussionRequest,
    @required this.getDiscussionResponse});
}
