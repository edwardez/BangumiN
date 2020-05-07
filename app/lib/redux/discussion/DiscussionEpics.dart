import 'package:munin/models/bangumi/discussion/GetDiscussionResponse.dart';
import 'package:munin/models/bangumi/discussion/thread/common/BangumiThread.dart';
import 'package:munin/models/bangumi/discussion/thread/common/GetThreadRequest.dart';
import 'package:munin/models/bangumi/discussion/thread/common/ThreadType.dart';
import 'package:munin/providers/bangumi/discussion/BangumiDiscussionService.dart';
import 'package:munin/redux/app/AppActions.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/discussion/DiscussionActions.dart';
import 'package:munin/shared/utils/misc/async.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

List<Epic<AppState>> createDiscussionEpics(
    BangumiDiscussionService bangumiDiscussionService) {
  final getDiscussionEpic = _createGetDiscussionEpic(bangumiDiscussionService);
  final getGroupThreadEpic =
      _createGetGroupThreadEpic(bangumiDiscussionService);

  final createReplyRequestEpic =
  _createCreateReplyRequestEpic(bangumiDiscussionService);

  final deleteReplyRequestEpic =
  _createDeleteReplyRequestEpic(bangumiDiscussionService);

  return [
    getDiscussionEpic,
    getGroupThreadEpic,
    createReplyRequestEpic,
    deleteReplyRequestEpic,
  ];
}

Stream<dynamic> _getDiscussion(
    EpicStore<AppState> store,
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
    action.completer.completeError(error, stack);
    yield HandleErrorAction(
      context: action.context,
      error: error,
      stack: stack,
      showErrorMessageSnackBar: true,
    );
  } finally {
    completeDanglingCompleter(action.completer);
  }
}

Epic<AppState> _createGetDiscussionEpic(
    BangumiDiscussionService bangumiDiscussionService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions.whereType<GetDiscussionRequestAction>().switchMap(
        (action) => _getDiscussion(store, bangumiDiscussionService, action));
  };
}

Stream<dynamic> _getGroupThread(
    EpicStore<AppState> store,
    BangumiDiscussionService bangumiDiscussionService,
    GetThreadRequestAction action) async* {
  try {
    BangumiThread thread;
    if (action.request.threadType == ThreadType.Group) {
      thread = await bangumiDiscussionService.getGroupThread(
        threadId: action.request.id,
        mutedUsers: store.state.settingState.muteSetting.mutedUsers,
        captionTextColor: action.captionTextColor,
      );
    } else if (action.request.threadType == ThreadType.Episode) {
      thread = await bangumiDiscussionService.getEpisodeThread(
        threadId: action.request.id,
        mutedUsers: store.state.settingState.muteSetting.mutedUsers,
        captionTextColor: action.captionTextColor,
      );
    } else if (action.request.threadType == ThreadType.SubjectTopic) {
      thread = await bangumiDiscussionService.getSubjectTopicThread(
        threadId: action.request.id,
        mutedUsers: store.state.settingState.muteSetting.mutedUsers,
        captionTextColor: action.captionTextColor,
      );
    } else if (action.request.threadType == ThreadType.Blog) {
      thread = await bangumiDiscussionService.getBlogThread(
        threadId: action.request.id,
        mutedUsers: store.state.settingState.muteSetting.mutedUsers,
        captionTextColor: action.captionTextColor,
      );
    }

    yield GetThreadRequestSuccessAction(
        thread: thread, request: action.request);
    action.completer.complete();
  } catch (error, stack) {
    completeWithErrorAndReport(
      error,
      action.completer,
      stack: stack,
    );
  } finally {
    completeDanglingCompleter(action.completer);
  }
}

Epic<AppState> _createGetGroupThreadEpic(
    BangumiDiscussionService bangumiDiscussionService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions
        .whereType<GetThreadRequestAction>()
        .switchMap((action) =>
        _getGroupThread(store, bangumiDiscussionService, action));
  };
}

Stream<dynamic> _createReplyRequestEpic(EpicStore<AppState> store,
    BangumiDiscussionService bangumiDiscussionService,
    CreateReplyRequestAction action) async* {
  try {
    await bangumiDiscussionService.createReply(
        reply: action.reply,
        threadType: action.threadType,
        targetPost: action.targetPost,
        threadId: action.threadId,
        author: store.state.currentAuthenticatedUserBasicInfo);

    final getThreadRequestAction = GetThreadRequestAction(
      request: GetThreadRequest((b) =>
      b
        ..threadType = action.threadType
        ..id = action.threadId),
      captionTextColor: defaultCaptionTextColorOrFallback(action.context),
    );

    yield getThreadRequestAction;

    await getThreadRequestAction.completer.future;
    action.completer.complete();
  } catch (error, stack) {
    completeWithErrorAndReport(
      error,
      action.completer,
      stack: stack,
    );
  } finally {
    // Might need to change to complete error?
    completeDanglingCompleter(action.completer);
  }
}

Epic<AppState> _createCreateReplyRequestEpic(
    BangumiDiscussionService bangumiDiscussionService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions
        .whereType<CreateReplyRequestAction>()
        .asyncExpand((action) =>
        _createReplyRequestEpic(store, bangumiDiscussionService, action));
  };
}

Stream<dynamic> _deleteRequestEpic(EpicStore<AppState> store,
    BangumiDiscussionService bangumiDiscussionService,
    DeleteReplyRequestAction action) async* {
  try {
    await bangumiDiscussionService.deleteReply(
      replyId: action.replyId,
      threadType: action.threadType,
    );

    final getThreadRequestAction = GetThreadRequestAction(
      request: GetThreadRequest((b) =>
      b
        ..threadType = action.threadType
        ..id = action.threadId),
      captionTextColor: action.captionTextColor,
    );

    yield getThreadRequestAction;

    await getThreadRequestAction.completer.future;
    action.completer.complete();
  } catch (error, stack) {
    completeWithErrorAndReport(
      error,
      action.completer,
      stack: stack,
    );
  } finally {
    // Might need to change to complete error?
    completeDanglingCompleter(action.completer);
  }
}

Epic<AppState> _createDeleteReplyRequestEpic(
    BangumiDiscussionService bangumiDiscussionService) {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions
        .whereType<DeleteReplyRequestAction>()
        .asyncExpand((action) =>
        _deleteRequestEpic(store, bangumiDiscussionService, action));
  };
}
