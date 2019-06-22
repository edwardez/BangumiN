import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/discussion/thread/common/GetThreadRequest.dart';
import 'package:munin/models/bangumi/discussion/thread/common/ThreadType.dart';
import 'package:munin/models/bangumi/discussion/thread/subject/SubjectTopicThread.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/discussion/DiscussionActions.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/discussion/thread/shared/MoreActions.dart';
import 'package:munin/widgets/discussion/thread/shared/PostWidget.dart';
import 'package:munin/widgets/discussion/thread/shared/ShareThread.dart';
import 'package:munin/widgets/discussion/thread/shared/SubjectCoverTitleTile.dart';
import 'package:munin/widgets/shared/appbar/AppBarTitleForSubject.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';
import 'package:munin/widgets/shared/common/RequestInProgressIndicatorWidget.dart';
import 'package:munin/widgets/shared/common/ScrollViewWithSliverAppBar.dart';
import 'package:redux/redux.dart';

/// A single discussion thread.
/// TODO: Waiting
/// https://github.com/flutter/flutter/issues/13253
/// https://github.com/flutter/flutter/issues/25802
/// to be closed to add a scrollbar.
class SubjectTopicThreadWidget extends StatelessWidget {
  final GetThreadRequest request;

  const SubjectTopicThreadWidget({Key key, @required this.request})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(request.threadType == ThreadType.SubjectTopic);

    Future<void> requestStatusFuture;
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store store) => _ViewModel.fromStore(store, request),
      distinct: true,
      onInit: (store) {
        final action = GetThreadRequestAction(
          request: request,
          captionTextColor: defaultCaptionText(context).color,
        );
        store.dispatch(action);
        requestStatusFuture = action.completer.future;
      },
      builder: (BuildContext context, _ViewModel vm) {
        if (vm.thread == null) {
          return RequestInProgressIndicatorWidget(
            retryCallback: vm.getThread,
            requestStatusFuture: requestStatusFuture,
          );
        } else {
          List<Widget> children = [];
          var parentBangumiContentType = BangumiContent.SubjectTopic;

          children.add(SubjectCoverTitleTile(
            name: vm.thread.parentSubject.name,
            imageUrl: vm.thread.parentSubject?.cover?.common,
            id: vm.thread.parentSubject.id,
          ));

          children.add(
            MuninPadding.vertical1xOffset(
              child: Text(
                vm.thread.title,
                style: Theme.of(context).textTheme.title,
              ),
            ),
          );

          for (var post in vm.thread.posts) {
            children.add(PostWidget(
              post: post,
              parentBangumiContentType: parentBangumiContentType,
              threadId: vm.thread.id,
            ));
          }

          return ScrollViewWithSliverAppBar(
            appBarMainTitle: Text(''),
            appBarSecondaryTitle: AppBarTitleForSubject(
              title: vm.thread.title,
              coverUrl: vm.thread?.parentSubject?.cover?.common,
            ),
            changeAppBarTitleOnScroll: true,
            safeAreaChildPadding: EdgeInsets.zero,
            enableBottomSafeArea: false,
            nestedScrollViewBody: ListView.builder(
              padding: EdgeInsets.only(bottom: bottomOffset),
              itemCount: children.length,
              itemBuilder: (context, index) {
                return children[index];
              },
            ),
            appBarActions: [
              ShareThread(
                thread: vm.thread,
                parentBangumiContent: parentBangumiContentType,
              ),
              MoreActions(
                parentBangumiContent: parentBangumiContentType,
                thread: vm.thread,
              ),
            ],
          );
        }
      },
    );
  }
}

class _ViewModel {
  final Future<void> Function(BuildContext context) getThread;
  final SubjectTopicThread thread;

  factory _ViewModel.fromStore(
      Store<AppState> store, GetThreadRequest request) {
    Future<void> _getThread(BuildContext context) {
      final action = GetThreadRequestAction(
        request: request,
        captionTextColor: defaultCaptionText(context).color,
      );
      store.dispatch(action);
      return action.completer.future;
    }

    return _ViewModel(
      getThread: _getThread,
      thread: store.state.discussionState.subjectTopicThreads[request.id],
    );
  }

  const _ViewModel({
    @required this.getThread,
    @required this.thread,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is _ViewModel &&
              runtimeType == other.runtimeType &&
              thread == other.thread;

  @override
  int get hashCode => thread.hashCode;
}
