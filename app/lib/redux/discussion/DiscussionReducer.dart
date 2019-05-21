import 'package:munin/models/bangumi/discussion/FetchDiscussionRequest.dart';
import 'package:munin/models/bangumi/discussion/FetchDiscussionResponse.dart';
import 'package:munin/redux/discussion/DiscussionActions.dart';
import 'package:munin/redux/discussion/DiscussionState.dart';
import 'package:redux/redux.dart';

final discussionReducers = combineReducers<DiscussionState>([
  TypedReducer<DiscussionState, GetDiscussionRequestSuccessAction>(
      searchSubjectSuccessReducer),
]);

DiscussionState searchSubjectSuccessReducer(DiscussionState discussionState,
    GetDiscussionRequestSuccessAction getDiscussionRequestSuccessAction) {
  FetchDiscussionRequest request =
      getDiscussionRequestSuccessAction.fetchDiscussionRequest;
  FetchDiscussionResponse response =
      getDiscussionRequestSuccessAction.fetchDiscussionResponse;

  return discussionState.rebuild((b) => b..results.addAll({request: response}));
}
