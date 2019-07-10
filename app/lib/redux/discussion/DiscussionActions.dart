import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionRequest.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionResponse.dart';
import 'package:munin/models/bangumi/discussion/thread/common/BangumiThread.dart';
import 'package:munin/models/bangumi/discussion/thread/common/GetThreadRequest.dart';
import 'package:munin/models/bangumi/discussion/thread/common/Post.dart';
import 'package:munin/models/bangumi/discussion/thread/common/ThreadType.dart';

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

class CreateReplyRequestAction {
  final int threadId;
  final ThreadType threadType;

  /// The target post that [reply] is sent against.
  /// Can be null if this reply is directly
  /// sent to the main post.
  final Post targetPost;

  /// Reply text that'll be sent out.
  final String reply;

  final BuildContext context;

  final Completer completer;

  CreateReplyRequestAction({
    @required this.threadId,
    @required this.threadType,
    @required this.reply,
    this.context,
    this.targetPost,
    Completer completer,
  }) : this.completer = completer ?? Completer();
}

class DeleteReplyRequestAction {
  final int threadId;
  final int replyId;
  final ThreadType threadType;
  final Color captionTextColor;

  final Completer completer;

  DeleteReplyRequestAction({
    @required this.threadId,
    @required this.replyId,
    @required this.threadType,
    @required this.captionTextColor,
    Completer completer,
  }) : this.completer = completer ?? Completer();
}
