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

  /// List older collections or list latest collections. Default to true.
  /// If set to true. Munin checks collections in store and automatically
  /// fetches collections on next page. If set false, Munin fetches the
  /// latest collections on first page.
  final bool listOlderCollections;

  ListUserCollectionsRequestAction({
    @required this.request,
    this.listOlderCollections = true,
    Completer completer,
  }) : this.completer = completer ?? Completer();
}

class ListUserCollectionsSuccessAction {
  final ListUserCollectionsRequest request;
  final ParsedCollections parsedCollections;

  /// Whether to append result to the end of results in store, or to head.
  /// Default to true. If results are latest collections, this should be set
  /// to false.
  final bool appendResultsToEnd;

  const ListUserCollectionsSuccessAction({
    @required this.request,
    @required this.parsedCollections,
    this.appendResultsToEnd = true,
  });
}
