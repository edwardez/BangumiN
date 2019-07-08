import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/discussion/thread/blog/BlogThread.dart';
import 'package:munin/models/bangumi/discussion/thread/common/BangumiThread.dart';
import 'package:munin/models/bangumi/discussion/thread/common/GetThreadRequest.dart';
import 'package:munin/models/bangumi/discussion/thread/common/Post.dart';
import 'package:munin/models/bangumi/discussion/thread/common/ThreadType.dart';
import 'package:munin/models/bangumi/discussion/thread/episode/EpisodeThread.dart';
import 'package:munin/models/bangumi/discussion/thread/group/GroupThread.dart';
import 'package:munin/models/bangumi/discussion/thread/subject/SubjectTopicThread.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/discussion/DiscussionActions.dart';
import 'package:munin/shared/exceptions/utils.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/discussion/common/DiscussionReplyWidgetComposer.dart';
import 'package:munin/widgets/discussion/thread/blog/BlogContentWidget.dart';
import 'package:munin/widgets/discussion/thread/shared/MoreActions.dart';
import 'package:munin/widgets/discussion/thread/shared/PostWidget.dart';
import 'package:munin/widgets/discussion/thread/shared/ShareThread.dart';
import 'package:munin/widgets/discussion/thread/shared/SubjectCoverTitleTile.dart';
import 'package:munin/widgets/shared/appbar/AppBarTitleForSubject.dart';
import 'package:munin/widgets/shared/appbar/AppbarWithLoadingIndicator.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';
import 'package:munin/widgets/shared/common/RequestInProgressIndicatorWidget.dart';
import 'package:munin/widgets/shared/common/ScrollViewWithSliverAppBar.dart';
import 'package:munin/widgets/shared/common/SnackBar.dart';
import 'package:munin/widgets/shared/html/BangumiHtml.dart';
import 'package:munin/widgets/shared/text/ExpandableText.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

/// A single discussion thread.
/// TODO: Waiting
/// https://github.com/flutter/flutter/issues/13253
/// https://github.com/flutter/flutter/issues/25802
/// to be closed to add a scrollbar.
class GenericThreadWidget extends StatefulWidget {
  final GetThreadRequest request;

  const GenericThreadWidget({Key key, @required this.request})
      : super(key: key);

  @override
  _GenericThreadWidgetState createState() => _GenericThreadWidgetState();
}

class _GenericThreadWidgetState extends State<GenericThreadWidget> {
  bool showSpoiler = false;

  toggleShowSpoiler() {
    setState(() {
      showSpoiler = !showSpoiler;
    });
  }

  List<Widget> _buildThreadHeadContent(
      BuildContext context, BangumiThread thread) {
    if (thread is BlogThread) {
      return [
        MuninPadding.vertical1xOffset(
          child: Text(
            thread.title,
            style: Theme.of(context).textTheme.title,
          ),
        ),
        BlogContentWidget(
          blogContent: thread.blogContent,
        ),
      ];
    } else if (thread is SubjectTopicThread) {
      return [
        SubjectCoverTitleTile(
          name: thread.parentSubject.name,
          imageUrl: thread.parentSubject?.cover?.common,
          id: thread.parentSubject.id,
        ),
        MuninPadding.vertical1xOffset(
          child: Text(
            thread.title,
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ];
    } else if (thread is GroupThread) {
      return [
        MuninPadding.vertical1xOffset(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                thread.groupName,
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                thread.title,
                style: Theme.of(context).textTheme.title,
              )
            ],
          ),
        )
      ];
    } else if (thread is EpisodeThread) {
      return [
        SubjectCoverTitleTile(
          name: thread.parentSubject.name,
          imageUrl: thread.parentSubject.cover?.common,
          id: thread.parentSubject.id,
        ),
        MuninPadding.vertical1xOffset(
          child: Text(
            thread.title,
            style: Theme.of(context).textTheme.title,
          ),
        ),
        MuninPadding.vertical1xOffset(
          child: ExpandableText(
            thread.descriptionHtml,
            key: PageStorageKey(
                'thread-${widget.request.threadType}-${thread.id}-description'),
            textRenderer: (descriptionHtml) => BangumiHtml(
              html: descriptionHtml,
            ),
            expandButtonText: '展开全部本集介绍',
            textLengthThreshold: 1000,
          ),
        ),
      ];
    } else {
      throw UnsupportedError('未支持的类型');
    }
  }

  Widget _buildAppBarMainTitle(BangumiThread thread,
      Future<void> requestStatusFuture) {
    Widget title;
    if (thread is BlogThread) {
      title = Text('日志');
    } else if (thread is SubjectTopicThread) {
      title = Text('作品话题');
    } else if (thread is GroupThread) {
      title = Text('小组话题');
    } else if (thread is EpisodeThread) {
      title = Text('章节讨论');
    } else {
      throw UnsupportedError('未支持的类型');
    }

    return WidgetWithLoadingIndicator(
      requestStatusFuture: requestStatusFuture,
      bottomStatusIndicator: Text(
        '刷新中',
        style: defaultCaptionText(context),
      ),
      child: title,
    );
  }

  _buildAppBarSecondaryTitle(BangumiThread thread) {
    if (thread is SubjectTopicThread) {
      return AppBarTitleForSubject(
        title: thread.title,
        coverUrl: thread?.parentSubject?.cover?.common,
      );
    } else if (thread is EpisodeThread) {
      return AppBarTitleForSubject(
        title: thread.title,
        coverUrl: thread?.parentSubject?.cover?.common,
      );
    } else {
      return Text(
        thread.title,
        style: Theme
            .of(context)
            .textTheme
            .body2,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> requestStatusFuture;
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store store) => _ViewModel.fromStore(store, widget.request),
      distinct: true,
      onInit: (store) {
        final action = GetThreadRequestAction(
          request: widget.request,
          captionTextColor: defaultCaptionText(context).color,
        );
        store.dispatch(action);
        requestStatusFuture = action.completer.future;
      },
      builder: (BuildContext context, _ViewModel vm) {
        BangumiThread thread = vm.thread;

        if (thread == null) {
          return RequestInProgressIndicatorWidget(
            retryCallback: vm.getThread,
            requestStatusFuture: requestStatusFuture,
          );
        } else {
          List<Widget> children = [];
          var parentBangumiContentType =
              widget.request.threadType.toBangumiContent;

          children.addAll(_buildThreadHeadContent(context, thread));

          for (var post in thread.posts) {
            children.add(PostWidget(
              post: post,
              parentBangumiContentType: parentBangumiContentType,
              threadId: thread.id,
              showSpoiler: showSpoiler,
              onDeletePost: (Post post) {
                vm.deleteReply(context, post.id);
              },
              appUsername: vm.username,
            ));
          }

          if (thread.mainPostReplies.isEmpty) {
            children.add(MuninPadding(
              child: Center(
                child: Text(
                  '暂无回复',
                  style: defaultCaptionText(context),
                ),
              ),
            ));
          }

          return ScrollViewWithSliverAppBar(
            appBarMainTitle:
            _buildAppBarMainTitle(vm.thread, requestStatusFuture),
            appBarSecondaryTitle: _buildAppBarSecondaryTitle(vm.thread),
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
              IconButton(
                icon: Icon(OMIcons.reply),
                onPressed: () {
                  showSnackBarOnSuccess(
                    context,
                    Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DiscussionReplyWidgetComposer.forCreateReply(
                              threadType: ThreadType.fromBangumiContent(
                                  parentBangumiContentType),
                              threadId: vm.thread.id,
                              appBarTitle:
                              '回复此${widget.request.threadType.toBangumiContent
                                  .chineseName}',
                            ),
                      ),
                    ),
                    '回复成功',
                  );
                },
              ),
              ShareThread(
                thread: vm.thread,
                parentBangumiContent: parentBangumiContentType,
              ),
              MoreActions(
                parentBangumiContent: parentBangumiContentType,
                thread: vm.thread,
                allSpoilersVisible: showSpoiler,
                toggleSpoilerCallback: toggleShowSpoiler,
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

  final void Function(BuildContext context, int replyId) deleteReply;

  final BangumiThread thread;

  final String username;

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

    void _deleteReply(BuildContext context, int replyId) async {
      final action = DeleteReplyRequestAction(
        threadType: request.threadType,
        replyId: replyId,
        threadId: request.id,
        captionTextColor: defaultCaptionTextColorOrFallback(context),
      );
      showTextOnSnackBar(context, '已提交删除回复的请求',
          duration: shortSnackBarDisplayDuration);

      store.dispatch(action);
      try {
        await action.completer.future;
        showTextOnSnackBar(context, '删除成功');
      } catch (error, stack) {
        showTextOnSnackBar(
            context, formatErrorMessage(error, fallbackErrorMessage: '删除出错'));
      }
    }

    BangumiThread thread;
    if (request.threadType == ThreadType.Blog) {
      thread = store.state.discussionState.blogThreads[request.id];
    } else if (request.threadType == ThreadType.SubjectTopic) {
      thread = store.state.discussionState.subjectTopicThreads[request.id];
    } else if (request.threadType == ThreadType.Group) {
      thread = store.state.discussionState.groupThreads[request.id];
    } else if (request.threadType == ThreadType.Episode) {
      thread = store.state.discussionState.episodeThreads[request.id];
    } else {
      throw UnsupportedError('未支持的类型');
    }

    return _ViewModel(
      getThread: _getThread,
      deleteReply: _deleteReply,
      thread: thread,
      username: store.state.currentAuthenticatedUserBasicInfo.username,
    );
  }

  const _ViewModel({
    @required this.getThread,
    @required this.deleteReply,
    @required this.thread,
    @required this.username,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          thread == other.thread;

  @override
  int get hashCode => hash2(thread, username);
}
