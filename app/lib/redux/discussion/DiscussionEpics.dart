import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionResponse.dart';
import 'package:munin/models/bangumi/discussion/thread/common/BangumiThread.dart';
import 'package:munin/models/bangumi/discussion/thread/common/ThreadType.dart';
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
  final getGroupThreadEpic =
  _createGetGroupThreadEpic(bangumiDiscussionService);
  return [
    getDiscussionEpic,
    getGroupThreadEpic,
  ];
}

Stream<dynamic> _getDiscussion(EpicStore<AppState> store,
    BangumiDiscussionService bangumiDiscussionService,
    GetDiscussionRequestAction action) async* {
  try {
    GetDiscussionResponse getDiscussionResponse =
        await bangumiDiscussionService.getRakuenTopics(
            getDiscussionRequest: action.getDiscussionRequest,
            muteSetting: store.state.settingState.muteSetting);

    yield GetDiscussionRequestSuccessAction(
        getDiscussionRequest: action.getDiscussionRequest,
        getDiscussionResponse: getDiscussionResponse);
    action.completer.complete();
  } catch (error, stack) {
    print(error.toString());
    print(stack);
    action.completer.completeError(error, stack);
    var result = await generalExceptionHandler(
      error,
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
        .switchMap((action) =>
            _getDiscussion(store, bangumiDiscussionService, action));
  };
}

Stream<dynamic> _getGroupThread(EpicStore<AppState> store,
    BangumiDiscussionService bangumiDiscussionService,
    GetThreadRequestAction action) async* {
  try {
    BangumiThread thread;
    if (action.request.threadType == ThreadType.Group) {
      thread = await bangumiDiscussionService.getGroupThread(
          threadId: action.request.id,
          mutedUsers: store.state.settingState.muteSetting.mutedUsers);
    } else if (action.request.threadType == ThreadType.Episode) {
      thread = await bangumiDiscussionService.getEpisodeThread(
          threadId: action.request.id,
          mutedUsers: store.state.settingState.muteSetting.mutedUsers);
    } else if (action.request.threadType == ThreadType.SubjectTopic) {
      thread = await bangumiDiscussionService.getSubjectTopicThread(
          threadId: action.request.id,
          mutedUsers: store.state.settingState.muteSetting.mutedUsers);
    } else if (action.request.threadType == ThreadType.Blog) {
      thread = await bangumiDiscussionService.getBlogThread(
          threadId: action.request.id,
          mutedUsers: store.state.settingState.muteSetting.mutedUsers);
    }


    yield GetThreadRequestSuccessAction(
        thread: thread, request: action.request);
  } catch (error, stack) {
    print(error.toString());
    print(stack);
    yield GetThreadRequestFailureAction.fromUnknownException(
        request: action.request);

    var result = await generalExceptionHandler(
      error,
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

Epic<AppState> _createGetGroupThreadEpic(
    BangumiDiscussionService bangumiDiscussionService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<GetThreadRequestAction>())
        .switchMap((action) =>
        _getGroupThread(store, bangumiDiscussionService, action));
  };
}
