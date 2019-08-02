import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/models/bangumi/user/collection/full/ListUserCollectionsRequest.dart';
import 'package:munin/models/bangumi/user/notification/BaseNotificationItem.dart';
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

/// Starts listening on unread notification.
class ListenOnUnreadNotificationAction {}

class ListNotificationItemsAction {
  final Completer completer;
  final bool onlyUnread;

  ListNotificationItemsAction({
    Completer completer,
    this.onlyUnread = true,
  }) : this.completer = completer ?? Completer();
}

class ListNotificationItemsSuccessAction {
  final BuiltList<BaseNotificationItem> items;
  final bool onlyUnread;

  ListNotificationItemsSuccessAction(this.items, {
    this.onlyUnread = true,
  });
}

class ClearUnreadNotificationsAction {
  final Completer completer;

  /// Whether all notifications should be cleared.
  ///
  /// Default to false.
  final bool clearAll;

  /// Whether a single notification should be cleared.
  ///
  /// Either [notificationId] or [clearAll] should be presented.
  final int notificationId;

  ClearUnreadNotificationsAction._(
      {this.notificationId, this.clearAll, Completer completer})
      : this.completer = completer ?? Completer();

  ClearUnreadNotificationsAction.clearAll() : this._(clearAll: true);

  ClearUnreadNotificationsAction.clearSingle(int notificationId)
      : this._(notificationId: notificationId);
}

enum ChangeFriendRelationshipType {
  /// Add a friend to user's friend list
  Add,

  /// Remove a friend to user's friend list
  Remove,
}

class ChangeFriendRelationshipRequestAction {
  final Completer completer;
  final int userId;

  /// Whether the intended change is to add
  final ChangeFriendRelationshipType actionType;

  ChangeFriendRelationshipRequestAction(this.userId, this.actionType,
      {Completer completer})
      : this.completer = completer ?? Completer();
}
