import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionResponse.dart';
import 'package:munin/providers/bangumi/discussion/BangumiDiscussionService.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/discussion/DiscussionActions.dart';
import 'package:munin/redux/oauth/OauthActions.dart';
import 'package:munin/redux/shared/ExceptionHandler.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

List<Epic<AppState>> createDiscussionEpics(
    BangumiDiscussionService bangumiDiscussionService) {
  final getDiscussionEpic = _createGetDiscussionEpic(bangumiDiscussionService);

  return [
    getDiscussionEpic,
  ];
}

Stream<dynamic> _getDiscussion(EpicStore<AppState> store,
    BangumiDiscussionService bangumiDiscussionService,
    GetDiscussionRequestAction action) async* {
  try {
    GetDiscussionResponse getDiscussionResponse =
        await bangumiDiscussionService.getRakuenTopics(
            getDiscussionRequest: action.getDiscussionRequest,
            muteSetting: store.state.settingState.muteSetting
        );

    yield GetDiscussionRequestSuccessAction(
        getDiscussionRequest: action.getDiscussionRequest,
        getDiscussionResponse: getDiscussionResponse);
    action.completer.complete();
  } catch (error, stack) {
    print(error.toString());
    print(stack);
    action.completer.completeError(error, stack);
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

Epic<AppState> _createGetDiscussionEpic(
    BangumiDiscussionService bangumiDiscussionService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<GetDiscussionRequestAction>())
        .switchMap(
            (action) =>
            _getDiscussion(store, bangumiDiscussionService, action));
  };
}
