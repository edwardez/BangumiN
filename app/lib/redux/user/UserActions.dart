import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';

class GetUserPreviewRequestAction {

  final String username;

  final Completer completer;

  GetUserPreviewRequestAction({@required this.username, Completer completer})
      : this.completer = completer ?? new Completer();
}

class GetUserPreviewSuccessAction {
  final UserProfile profile;

  GetUserPreviewSuccessAction({@required this.profile});
}
