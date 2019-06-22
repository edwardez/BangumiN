import 'package:munin/models/bangumi/BangumiUserSmall.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/providers/bangumi/user/BangumiUserService.dart';
import 'package:munin/providers/bangumi/user/parser/UserCollectionsListParser.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/user/UserActions.dart';
import 'package:munin/shared/utils/misc/async.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

List<Epic<AppState>> createUserEpics(BangumiUserService bangumiUserService) {
  final getUserPreviewEpic = _createGetUserPreviewEpic(bangumiUserService);
  final listUserCollectionsEpic =
      _createListUserCollectionsEpic(bangumiUserService);

  return [
    getUserPreviewEpic,
    listUserCollectionsEpic,
  ];
}

Stream<dynamic> _getDiscussionEpic(BangumiUserService bangumiUserService,
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
    print(error.toString());
    print(stack);
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
        .switchMap((action) => _getDiscussionEpic(bangumiUserService, action));
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

    if (responseInStore != null && !responseInStore.canLoadMoreItems) {
      await Future.wait(futuresToWait);
      action.completer.complete();
      return;
    }

    int requestedUntilPageNumber =
        responseInStore?.requestedUntilPageNumber ?? 0;

    /// Note that [listUserCollections] needs to be kept as last in
    /// [futuresToWait] since [results.last] is used to identify this result.
    futuresToWait.add(bangumiUserService.listUserCollections(
      requestedPageNumber: requestedUntilPageNumber + 1,
      request: action.request,
    ));
    final results = await Future.wait(futuresToWait);

    ParsedCollections parsedCollections = results.last;

    yield ListUserCollectionsSuccessAction(
      parsedCollections: parsedCollections,
      request: action.request,
    );
  } catch (error, stack) {
    print(error.toString());
    print(stack);
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
