import 'package:munin/models/bangumi/BangumiUserSmall.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/providers/bangumi/user/BangumiUserService.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/user/UserActions.dart';
import 'package:munin/shared/utils/misc/async.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

List<Epic<AppState>> createUserEpics(BangumiUserService bangumiUserService) {
  final fetchUserPreviewEpic = _createFetchUserPreviewEpic(bangumiUserService);

  return [
    fetchUserPreviewEpic,
  ];
}

Stream<dynamic> _getDiscussion(BangumiUserService bangumiUserService,
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
    action.completer.completeError(error);
  } finally {
    completeDanglingCompleter(action.completer);
  }
}

Epic<AppState> _createFetchUserPreviewEpic(
    BangumiUserService bangumiUserService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<GetUserPreviewRequestAction>())
        .switchMap((action) => _getDiscussion(bangumiUserService, action));
  };
}
