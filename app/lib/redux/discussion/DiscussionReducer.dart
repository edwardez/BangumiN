import 'package:munin/models/bangumi/discussion/GetDiscussionRequest.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionResponse.dart';
import 'package:munin/models/bangumi/discussion/thread/blog/BlogThread.dart';
import 'package:munin/models/bangumi/discussion/thread/common/ThreadType.dart';
import 'package:munin/models/bangumi/discussion/thread/episode/EpisodeThread.dart';
import 'package:munin/models/bangumi/discussion/thread/group/GroupThread.dart';
import 'package:munin/models/bangumi/discussion/thread/subject/SubjectTopicThread.dart';
import 'package:munin/redux/discussion/DiscussionActions.dart';
import 'package:munin/redux/discussion/DiscussionState.dart';
import 'package:redux/redux.dart';

final discussionReducers = combineReducers<DiscussionState>([
  TypedReducer<DiscussionState, GetDiscussionRequestSuccessAction>(
      getDiscussionSuccessReducer),
  TypedReducer<DiscussionState, GetThreadRequestSuccessAction>(
      getGroupThreadSuccessReducer),
]);

DiscussionState getDiscussionSuccessReducer(DiscussionState discussionState,
    GetDiscussionRequestSuccessAction action) {
  GetDiscussionRequest request = action.getDiscussionRequest;
  GetDiscussionResponse response = action.getDiscussionResponse;

  return discussionState
      .rebuild((b) => b..discussions.addAll({request: response}));
}

DiscussionState getGroupThreadSuccessReducer(DiscussionState discussionState,
    GetThreadRequestSuccessAction action) {
  if (action.request.threadType == ThreadType.Group) {
    assert(action.thread is GroupThread);
    return discussionState.rebuild(
            (b) => b..groupThreads.addAll({action.thread.id: action.thread}));
  } else if (action.request.threadType == ThreadType.Episode) {
    assert(action.thread is EpisodeThread);
    return discussionState.rebuild(
            (b) => b..episodeThreads.addAll({action.thread.id: action.thread}));
  } else if (action.request.threadType == ThreadType.SubjectTopic) {
    assert(action.thread is SubjectTopicThread);
    return discussionState.rebuild(
            (b) =>
        b
          ..subjectTopicThreads.addAll({action.thread.id: action.thread}));
  } else if (action.request.threadType == ThreadType.Blog) {
    assert(action.thread is BlogThread);
    return discussionState.rebuild(
            (b) => b..blogThreads.addAll({action.thread.id: action.thread}));
  }


  return null;

}
