import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/discussion/thread/blog/BlogThread.dart';
import 'package:munin/models/bangumi/discussion/thread/common/GetThreadRequest.dart';
import 'package:munin/models/bangumi/discussion/thread/common/ThreadType.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/discussion/DiscussionActions.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/discussion/thread/blog/BlogContentWidget.dart';
import 'package:munin/widgets/discussion/thread/shared/MoreActions.dart';
import 'package:munin/widgets/discussion/thread/shared/PostWidget.dart';
import 'package:munin/widgets/discussion/thread/shared/ShareThread.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';
import 'package:munin/widgets/shared/common/RequestInProgressIndicatorWidget.dart';
import 'package:munin/widgets/shared/common/ScaffoldWithSliverAppBar.dart';
import 'package:redux/redux.dart';

/// A single discussion thread.
/// TODO: Waiting
/// https://github.com/flutter/flutter/issues/13253
/// https://github.com/flutter/flutter/issues/25802
/// to be closed to add a scrollbar.
class BlogThreadWidget extends StatelessWidget {
  final GetThreadRequest request;

  const BlogThreadWidget({Key key, @required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(request.threadType == ThreadType.Blog);

    return StoreConnector<AppState, _ViewModel>(
      converter: (Store store) => _ViewModel.fromStore(store, request),
      distinct: true,
      onInit: (store) {
        final action =
            GetThreadRequestAction(context: context, request: request);
        store.dispatch(action);
      },
      builder: (BuildContext context, _ViewModel vm) {
        if (vm.thread == null) {
          return RequestInProgressIndicatorWidget(
              loadingStatus: vm.loadingStatus,
              refreshAction:
                  GetThreadRequestAction(context: context, request: request));
        } else {
          List<Widget> children = [];
          var parentBangumiContentType = BangumiContent.Blog;
          children.add(
            MuninPadding.vertical1xOffset(
              child: Text(
                vm.thread.title,
                style: Theme.of(context).textTheme.title,
              ),
            ),
          );

          children.add(
            BlogContentWidget(
              blogContent: vm.thread.blogContent,
            ),
          );

          for (var post in vm.thread.posts) {
            children.add(PostWidget(
              post: post,
              parentBangumiContentType: parentBangumiContentType,
              threadId: vm.thread.id,
            ));
          }

          return ScaffoldWithSliverAppBar(
            appBarMainTitle: Text(''),
            appBarSecondaryTitle: Text(vm.thread.title),
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
  final Function(BuildContext context) getThread;
  final BlogThread thread;
  final LoadingStatus loadingStatus;

  factory _ViewModel.fromStore(
      Store<AppState> store, GetThreadRequest request) {
    _getThread(BuildContext context) {
      final action = GetThreadRequestAction(context: context, request: request);
      store.dispatch(action);
    }

    return _ViewModel(
      getThread: _getThread,
      thread: store.state.discussionState.blogThreads[request.id],
      loadingStatus:
          store.state.discussionState.getThreadLoadingStatus[request],
    );
  }

  const _ViewModel({
    @required this.getThread,
    @required this.thread,
    @required this.loadingStatus,
  });
}
