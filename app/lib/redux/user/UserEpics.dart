import 'package:munin/models/bangumi/BangumiUserSmall.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/providers/bangumi/user/BangumiUserService.dart';
import 'package:munin/providers/bangumi/user/parser/UserCollectionsListParser.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/user/UserActions.dart';
import 'package:munin/shared/exceptions/utils.dart';
import 'package:munin/shared/utils/misc/async.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

List<Epic<AppState>> createUserEpics(BangumiUserService bangumiUserService) {
  return [
    _createGetUserPreviewEpic(bangumiUserService),
    _createListUserCollectionsEpic(bangumiUserService),
    _createListNotificationItemsEpic(bangumiUserService),
    _createListenOnUnreadNotificationsEpic(bangumiUserService),
    _createClearUnreadNotificationsEpic(bangumiUserService),
    _createChangeFriendRelationshipEpic(bangumiUserService),
  ];
}

Stream<dynamic> _getUserPreviewEpic(BangumiUserService bangumiUserService,
    GetUserPreviewRequestAction action) async* {
  try {
    List results = await Future.wait([
      bangumiUserService.getUserBasicInfo(action.username),
      bangumiUserService.getUserPreview(action.username)
    ]);

    BangumiUserSmall basicInfo = results[0];
    UserProfile profile = results[1];

    profile = profile.rebuild((b) => b..basicInfo.replace(basicInfo));

    yield GetUserPreviewSuccessAction(profile: profile);
    action.completer.complete();
  } catch (error, stack) {
    reportError(error, stack: stack);
    action.completer.completeError(error, stack);
  } finally {
    completeDanglingCompleter(action.completer);
  }
}

Epic<AppState> _createGetUserPreviewEpic(
    BangumiUserService bangumiUserService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<GetUserPreviewRequestAction>())
        .switchMap((action) => _getUserPreviewEpic(bangumiUserService, action));
  };
}

Stream<dynamic> _listUserCollectionsEpic(
  BangumiUserService bangumiUserService,
  EpicStore<AppState> store,
  ListUserCollectionsRequestAction action,
) async* {
  try {
    // Subject should always be non-null as user must access subject widget first
    // then review widget, if this is not true, throws an exception in dev
    // environment.
    List<Future> futuresToWait = [];
    final user = store.state.userState.profiles[action.request.username];

    if (user == null) {
      final getUserAction =
          GetUserPreviewRequestAction(username: action.request.username);
      yield getUserAction;

      futuresToWait.add(getUserAction.completer.future);
    }

    final responseInStore = store.state.userState.collections[action.request];

    // If there are collections in store, and no more items can be loaded
    // while [action] requests to load more items. Immediately returns
    // after waiting for [futuresToWait].
    if (responseInStore != null &&
        !responseInStore.canLoadMoreItems &&
        action.listOlderCollections) {
      await Future.wait(futuresToWait);
      action.completer.complete();
      return;
    }

    int webPageNumber;
    if (responseInStore == null) {
      webPageNumber = 1;
    } else {
      if (action.listOlderCollections) {
        webPageNumber = responseInStore.requestedUntilPageNumber + 1;
      } else {
        webPageNumber = 1;
      }
    }

    /// Note that [listUserCollections] needs to be kept as last in
    /// [futuresToWait] since [results.last] is used to identify this result.
    futuresToWait.add(bangumiUserService.listUserCollections(
      webPageNumber: webPageNumber,
      request: action.request,
    ));
    final results = await Future.wait(futuresToWait);

    ParsedCollections parsedCollections = results.last;

    yield ListUserCollectionsSuccessAction(
      parsedCollections: parsedCollections,
      request: action.request,
      appendResultsToEnd: action.listOlderCollections,
    );
  } catch (error, stack) {
    reportError(error, stack: stack);
    action.completer.completeError(error, stack);
  } finally {
    completeDanglingCompleter(action.completer);
  }
}

Epic<AppState> _createListUserCollectionsEpic(
    BangumiUserService bangumiUserService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<ListUserCollectionsRequestAction>())
        .switchMap((action) => _listUserCollectionsEpic(
              bangumiUserService,
              store,
              action,
            ));
  };
}

Stream<dynamic> _listNotificationItemsEpic(
    BangumiUserService bangumiUserService,
    ListNotificationItemsAction action,) async* {
  try {
    final items = await bangumiUserService.listNotifications(
      onlyUnread: action.onlyUnread,
    );

    yield ListNotificationItemsSuccessAction(items,
        onlyUnread: action.onlyUnread);
    action.completer.complete();
  } catch (error, stack) {
    reportError(error, stack: stack);
    action.completer.completeError(error, stack);
  } finally {
    completeDanglingCompleter(action.completer);
  }
}

Epic<AppState> _createListNotificationItemsEpic(
    BangumiUserService bangumiUserService,) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<ListNotificationItemsAction>())
        .switchMap((action) =>
        _listNotificationItemsEpic(
          bangumiUserService,
          action,
        ));
  };
}

const listenOnUnreadNotificationsInterval = const Duration(seconds: 15);

/// Listens on unread notifications, update store if unread messages are not the
/// same as notifications in store.
Stream<dynamic> _listenOnUnreadNotificationsEpic(EpicStore<AppState> store,
    BangumiUserService bangumiUserService,
    ListenOnUnreadNotificationAction action,) async* {
  try {
    final unreadCountHttp =
    await bangumiUserService.getUnreadNotificationsCount();
    final unreadCountInStore =
        store.state.userState.notificationState.unreadNotificationItems?.length;

    // Returns early to avoid one more http call if count matches.
    if (unreadCountHttp == unreadCountInStore) {
      return;
    }

    final items = await bangumiUserService.listNotifications();

    if (items !=
        store.state.userState.notificationState.unreadNotificationItems) {
      yield ListNotificationItemsSuccessAction(items);
    }
  } catch (error, stack) {
    reportError(error, stack: stack);
  }
}

Epic<AppState> _createListenOnUnreadNotificationsEpic(
    BangumiUserService bangumiUserService,) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<ListenOnUnreadNotificationAction>())
        .switchMap<ListenOnUnreadNotificationAction>(
            (action) =>
            Observable.concat(
              [
                Observable.just(action),
                Observable.periodic(
                    listenOnUnreadNotificationsInterval, (i) => action)
              ],
            ))
        .switchMap((action) =>
        _listenOnUnreadNotificationsEpic(
          store,
          bangumiUserService,
          action,
        ));
  };
}

Stream<dynamic> _clearUnreadNotificationsEpic(EpicStore<AppState> store,
    BangumiUserService bangumiUserService,
    ClearUnreadNotificationsAction action,) async* {
  try {
    await bangumiUserService.clearUnreadNotifications(
      notificationId: action.notificationId,
      clearAll: action.clearAll,
    );
    action.completer.complete();

    /// Refresh notifications in store.
    yield ListNotificationItemsAction();
  } catch (error, stack) {
    action.completer.completeError(error);
    reportError(error, stack: stack);
  } finally {
    completeDanglingCompleter(action.completer);
  }
}

Epic<AppState> _createClearUnreadNotificationsEpic(
    BangumiUserService bangumiUserService,) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<ClearUnreadNotificationsAction>())
        .concatMap((action) =>
        _clearUnreadNotificationsEpic(
          store,
          bangumiUserService,
          action,
        ));
  };
}


Stream<dynamic> _changeFriendRelationshipEpic(
    BangumiUserService bangumiUserService,
    ChangeFriendRelationshipRequestAction action,) async* {
  try {
    await bangumiUserService.changeFriendRelationship(
        userId: action.userId,
        actionType: action.actionType
    );

    action.completer.complete();
  } catch (error, stack) {
    action.completer.completeError(error);
    reportError(error, stack: stack);
  } finally {
    completeDanglingCompleter(action.completer);
  }
}

Epic<AppState> _createChangeFriendRelationshipEpic(
    BangumiUserService bangumiUserService,) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<ChangeFriendRelationshipRequestAction>())
        .concatMap((action) =>
        _changeFriendRelationshipEpic(
          bangumiUserService,
          action,
        ));
  };
}