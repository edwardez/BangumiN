import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/BangumiUserBaic.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/providers/bangumi/user/BangumiUserService.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/oauth/OauthActions.dart';
import 'package:munin/redux/shared/ExceptionHandler.dart';
import 'package:munin/redux/user/UserActions.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

List<Epic<AppState>> createUserEpics(BangumiUserService bangumiUserService) {
  final fetchUserPreviewEpic = _createFetchUserPreviewEpic(bangumiUserService);

  return [
    fetchUserPreviewEpic,
  ];
}

Stream<dynamic> _getDiscussion(BangumiUserService bangumiUserService,
    FetchUserPreviewRequestAction action) async* {
  try {
    yield FetchUserPreviewLoadingAction(username: action.username);

    List results = await Future.wait([
      bangumiUserService.getUserBasicInfo(action.username),
      bangumiUserService.getUserPreview(action.username)
    ]);

    BangumiUserBasic basicInfo = results[0];
    UserProfile profile = results[1];

    profile = profile.rebuild((b) => b..basicInfo.replace(basicInfo));

    yield FetchUserPreviewSuccessAction(profile: profile);
  } catch (error, stack) {
    print(error.toString());
    print(stack);
    yield FetchUserPreviewFailureAction.fromUnknownException(
        username: action.username);

    var result = await generalExceptionHandler(error,
      context: action.context,
    );
    if (result == GeneralExceptionHandlerResult.RequiresReAuthentication) {
      yield OAuthLoginRequest(action.context);
    } else if (result == GeneralExceptionHandlerResult.Skipped) {
      return;
    }

    Scaffold.of(action.context)
        .showSnackBar(SnackBar(content: Text(error.toString())));
  }
}

Epic<AppState> _createFetchUserPreviewEpic(
    BangumiUserService bangumiUserService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<FetchUserPreviewRequestAction>())
        .switchMap((action) => _getDiscussion(bangumiUserService, action));
  };
}
