import 'package:munin/models/bangumi/discussion/GetDiscussionRequest.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionResponse.dart';
import 'package:munin/redux/discussion/DiscussionActions.dart';
import 'package:munin/redux/discussion/DiscussionState.dart';
import 'package:redux/redux.dart';

final discussionReducers = combineReducers<DiscussionState>([
  TypedReducer<DiscussionState, GetDiscussionRequestSuccessAction>(
      searchSubjectSuccessReducer),
]);

DiscussionState searchSubjectSuccessReducer(DiscussionState discussionState,
    GetDiscussionRequestSuccessAction getDiscussionRequestSuccessAction) {
  GetDiscussionRequest request =
      getDiscussionRequestSuccessAction.getDiscussionRequest;
  GetDiscussionResponse response =
      getDiscussionRequestSuccessAction.getDiscussionResponse;

  return discussionState.rebuild((b) => b..results.addAll({request: response}));
}
