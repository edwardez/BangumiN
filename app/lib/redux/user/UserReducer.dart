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
    responseInStore = responseInStore.rebuild(
          (b) =>
      b
        ..listUserCollectionsRequest.replace(action.request)
        ..collections.addAll(action.parsedCollections.collections)
        ..userCollectionTags.replace(
            BuiltMap<String, UserCollectionTag>.of(
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
        ..userCollectionTags.replace(
            BuiltMap<String, UserCollectionTag>.of(
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
