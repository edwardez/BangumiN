import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/redux/shared/CommonActions.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';

class FetchUserPreviewRequestAction {
  final BuildContext context;
  final String username;

  final Completer completer;

  FetchUserPreviewRequestAction(
      {@required this.context, @required this.username, Completer completer})
      : this.completer = completer ?? new Completer();
}

class FetchUserPreviewLoadingAction {
  final String username;

  FetchUserPreviewLoadingAction({
    @required this.username,
  });
}

class FetchUserPreviewSuccessAction {
  final UserProfile profile;

  FetchUserPreviewSuccessAction({@required this.profile});
}

class FetchUserPreviewFailureAction extends FailureAction {
  final String username;

  FetchUserPreviewFailureAction(
      {@required this.username, @required LoadingStatus loadingStatus})
      : super(loadingStatus: loadingStatus);

  FetchUserPreviewFailureAction.fromUnknownException({@required this.username})
      : super.fromUnknownException();
}
