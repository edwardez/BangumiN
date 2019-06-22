import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/models/bangumi/user/collection/full/ListUserCollectionsRequest.dart';
import 'package:munin/providers/bangumi/user/parser/UserCollectionsListParser.dart';

class GetUserPreviewRequestAction {
  final String username;

  final Completer completer;

  GetUserPreviewRequestAction({@required this.username, Completer completer})
      : this.completer = completer ?? Completer();
}

class GetUserPreviewSuccessAction {
  final UserProfile profile;

  const GetUserPreviewSuccessAction({@required this.profile});
}

class ListUserCollectionsRequestAction {
  final ListUserCollectionsRequest request;

  final Completer completer;

  ListUserCollectionsRequestAction({
    @required this.request,
    Completer completer,
  }) : this.completer = completer ?? Completer();
}

class ListUserCollectionsSuccessAction {
  final ListUserCollectionsRequest request;
  final ParsedCollections parsedCollections;

  const ListUserCollectionsSuccessAction({
    @required this.request,
    @required this.parsedCollections,
  });
}
