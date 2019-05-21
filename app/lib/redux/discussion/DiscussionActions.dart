import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/discussion/FetchDiscussionRequest.dart';
import 'package:munin/models/bangumi/discussion/FetchDiscussionResponse.dart';

class GetDiscussionRequestAction {
  final BuildContext context;
  final FetchDiscussionRequest fetchDiscussionRequest;
  final Completer completer;

  GetDiscussionRequestAction(
      {@required this.context,
      @required this.fetchDiscussionRequest,
      Completer completer})
      : this.completer = completer ?? new Completer();
}

class GetDiscussionRequestSuccessAction {
  final FetchDiscussionRequest fetchDiscussionRequest;
  final FetchDiscussionResponse fetchDiscussionResponse;

  GetDiscussionRequestSuccessAction(
      {@required this.fetchDiscussionRequest,
      @required this.fetchDiscussionResponse});
}
