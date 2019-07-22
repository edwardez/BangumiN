import 'package:built_collection/built_collection.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/models/bangumi/user/collection/full/CollectionOnUserList.dart';
import 'package:munin/models/bangumi/user/collection/full/ListUserCollectionsResponse.dart';
import 'package:munin/models/bangumi/user/collection/full/UserCollectionTag.dart';
import 'package:munin/redux/user/UserActions.dart';
import 'package:munin/redux/user/UserState.dart';
import 'package:redux/redux.dart';

final userReducers = combineReducers<UserState>([
  TypedReducer<UserState, GetUserPreviewSuccessAction>(
      fetchUserPreviewSuccessReducer),
  TypedReducer<UserState, ListUserCollectionsSuccessAction>(
      listUserCollectionsSuccessReducer),
  TypedReducer<UserState, ListNotificationItemsSuccessAction>(
      listNotificationItemsSuccessReducer),
]);

UserState fetchUserPreviewSuccessReducer(UserState userState,
    GetUserPreviewSuccessAction fetchUserPreviewSuccessAction) {
  UserProfile profile = fetchUserPreviewSuccessAction.profile;
  String username = profile.basicInfo.username;
  return userState.rebuild(
        (b) => b..profiles.addAll({username: profile}),
  );
}

UserState listUserCollectionsSuccessReducer(UserState userState,
    ListUserCollectionsSuccessAction action) {
  if (!action.parsedCollections.isRequestedPageNumberValid) {
    return userState;
  }

  ListUserCollectionsResponse responseInStore =
  userState.collections[action.request];
  if (responseInStore != null) {
    BuiltMap<int, CollectionOnUserList> updatedCollectionsInStore;
    if (action.appendResultsToEnd) {
      updatedCollectionsInStore = responseInStore.collections
          .rebuild((b) => b..addAll(action.parsedCollections.collections));
    } else {
      updatedCollectionsInStore = BuiltMap<int, CollectionOnUserList>.of(
          action.parsedCollections.collections);

      // In most cases collections in store are a larget data set. Looping
      // through it might be inefficient. Maybe looping the smaller data set
      // instead?
      for (var collection in responseInStore.collections.values) {
        updatedCollectionsInStore.rebuild(
                (b) => b.putIfAbsent(collection.subject.id, () => collection));
      }
    }

    responseInStore = responseInStore.rebuild(
          (b) =>
      b
        ..listUserCollectionsRequest.replace(action.request)
        ..collections.replace(updatedCollectionsInStore)
        ..userCollectionTags.replace(BuiltMap<String, UserCollectionTag>.of(
            action.parsedCollections.tags))
        ..canLoadMoreItems = action.parsedCollections.canLoadMoreItems ?? true
        ..requestedUntilPageNumber += 1,
    );
  } else {
    responseInStore = ListUserCollectionsResponse(
          (b) =>
      b
        ..listUserCollectionsRequest.replace(action.request)
        ..collections.replace(
          BuiltMap<int, CollectionOnUserList>.of(
              action.parsedCollections.collections),
        )
        ..userCollectionTags.replace(BuiltMap<String, UserCollectionTag>.of(
            action.parsedCollections.tags))
        ..canLoadMoreItems = action.parsedCollections.canLoadMoreItems ?? true
        ..requestedUntilPageNumber = 1,
    );
  }

  return userState.rebuild((b) =>
  b
    ..collections.addAll(
      {action.request: responseInStore},
    ));
}

UserState listNotificationItemsSuccessReducer(UserState userState,
    ListNotificationItemsSuccessAction action) {
  if (action.onlyUnread) {
    return userState.rebuild((b) =>
    b
      ..notificationState
          .unreadNotificationItems
          .replace(action.items));
  } else {
    return userState.rebuild((b) =>
    b
      ..notificationState
          .allNotificationItems
          .replace(action.items));
  }
}
