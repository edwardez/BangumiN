import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/discussion/FetchDiscussionResponse.dart';
import 'package:munin/providers/bangumi/discussion/BangumiDiscussionService.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/discussion/DiscussionActions.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

List<Epic<AppState>> createDiscussionEpics(
    BangumiDiscussionService bangumiDiscussionService) {
  final getDiscussionEpic = _createGetDiscussionEpic(bangumiDiscussionService);

  return [
    getDiscussionEpic,
  ];
}

Stream<dynamic> _getDiscussion(
    BangumiDiscussionService bangumiDiscussionService,
    GetDiscussionRequestAction action) async* {
  try {
    FetchDiscussionResponse fetchDiscussionResponse =
        await bangumiDiscussionService.getRakuenTopics(
            fetchDiscussionRequest: action.fetchDiscussionRequest);

    yield GetDiscussionRequestSuccessAction(
        fetchDiscussionRequest: action.fetchDiscussionRequest,
        fetchDiscussionResponse: fetchDiscussionResponse);
    action.completer.complete();
  } catch (error, stack) {
    print(error.toString());
    print(stack);
    action.completer.completeError(error, stack);
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
            (action) => _getDiscussion(bangumiDiscussionService, action));
  };
}
