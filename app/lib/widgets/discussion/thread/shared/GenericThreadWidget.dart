
import 'package:flutter/cupertino.dart';
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
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/discussion/DiscussionActions.dart';
import 'package:munin/redux/shared/utils.dart';
import 'package:munin/shared/exceptions/utils.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/discussion/common/DiscussionReplyWidgetComposer.dart';
import 'package:munin/widgets/discussion/thread/blog/BlogContentWidget.dart';
import 'package:munin/widgets/discussion/thread/shared/Constants.dart';
import 'package:munin/widgets/discussion/thread/shared/MoreActions.dart';
import 'package:munin/widgets/discussion/thread/shared/PostWidget.dart';
import 'package:munin/widgets/discussion/thread/shared/ReadModeSwitcher.dart';
import 'package:munin/widgets/discussion/thread/shared/SubjectCoverTitleTile.dart';
import 'package:munin/widgets/shared/appbar/AppbarWithLoadingIndicator.dart';
import 'package:munin/widgets/shared/bottomsheet/showMinHeightModalBottomSheet.dart';
import 'package:munin/widgets/shared/button/FilledFlatButton.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';
import 'package:munin/widgets/shared/common/RequestInProgressIndicatorWidget.dart';
import 'package:munin/widgets/shared/common/SnackBar.dart';
import 'package:munin/widgets/shared/dialog/common.dart';
import 'package:munin/widgets/shared/html/BangumiHtml.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';
import 'package:munin/widgets/shared/refresh/MuninRefresh.dart';
import 'package:munin/widgets/shared/text/ExpandableText.dart';
import 'package:munin/widgets/shared/utils/Scroll.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

/// A single discussion thread.
/// TODO: Waiting
/// https://github.com/flutter/flutter/issues/13253
/// https://github.com/flutter/flutter/issues/25802
/// to be closed to add a scrollbar.
class GenericThreadWidget extends StatefulWidget {
  final GetThreadRequest request;

  /// An additional [postId], if this value is presented, only the specific
  /// post with [postId] will be shown, otherwise all posts under the thread
  /// will be shown.
  final int postId;

  const GenericThreadWidget({
    Key key,
    @required this.request,
    this.postId,
  }) : super(key: key);

  @override
  _GenericThreadWidgetState createState() => _GenericThreadWidgetState();
}

class _GenericThreadWidgetState extends State<GenericThreadWidget> {
  bool showSpoiler = false;
  PostReadMode postReadMode = PostReadMode.Normal;

  final _muninRefreshKey = GlobalKey<MuninRefreshState>();
  Future<void> requestStatusFuture;

  toggleShowSpoiler() {
    setState(() {
      showSpoiler = !showSpoiler;
    });
  }

  List<Widget> _buildThreadHeadContent(BuildContext context, BangumiThread thread) {
    if (thread is BlogThread) {
      return [
        MuninPadding.vertical1xOffset(
          child: Text(
            thread.title,
            style: Theme.of(context).textTheme.headline6,
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
            style: Theme
                .of(context)
                .textTheme
                .headline6,
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
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6,
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
            style: Theme
                .of(context)
                .textTheme
                .headline6,
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

  Widget _buildAppBarTitle(BangumiThread thread,
      Future<void> requestStatusFuture) {
    final title = Row(
      children: <Widget>[
        Flexible(
            child: Text(
              thread.title,
              overflow: TextOverflow.fade,
              style: Theme
                  .of(context)
                  .textTheme
                  .body2,
            )),
      ],
    );

    return WidgetWithLoadingIndicator(
      requestStatusFuture: requestStatusFuture,
      bottomStatusIndicator: Text(
        '刷新中',
        style: defaultCaptionText(context),
      ),
      child: title,
    );
  }

  Post _findPostById(int postId, List<Post> posts) {
    return posts.firstWhere((post) => post.id == postId, orElse: () => null);
  }

  List<Widget> _buildSpecificPostWidgets(Post post,
      _ViewModel vm,
      BangumiContent parentBangumiContentType,) {
    return [
      PostWidget(
        post: post,
        parentBangumiContentType: parentBangumiContentType,
        threadId: vm.thread.id,
        showSpoiler: showSpoiler,
        onDeletePost: (Post post) {
          vm.deleteReply(context, post.id);
        },
        appUsername: vm.username,
        isInFlattenedReadMode: true,
      ),
      MuninPadding(
        child: Column(
          children: <Widget>[
            Text('当前仅展示指定楼层'),
            FilledFlatButton(
              child: Text('展示所有楼层'),
              onPressed: () {
                setState(() {
                  postReadMode = PostReadMode.Normal;
                });
              },
            )
          ],
        ),
      )
    ];
  }

  List<Widget> _buildNestedPostWidgets(_ViewModel vm,
      List<Post> posts,
      BangumiContent parentBangumiContentType,) {
    final thread = vm.thread;

    return [
      ..._buildThreadHeadContent(context, thread),
      for (var post in posts)
        PostWidget(
          post: post,
          parentBangumiContentType: parentBangumiContentType,
          threadId: thread.id,
          showSpoiler: showSpoiler,
          onDeletePost: (Post post) {
            vm.deleteReply(context, post.id);
          },
          appUsername: vm.username,
        ),
    ];
  }

  List<Widget> _buildFlattenedPostWidgets(_ViewModel vm,
      BangumiContent parentBangumiContentType,) {
    final thread = vm.thread;

    return [
      ..._buildThreadHeadContent(context, thread),
      for (var post in thread.newestFirstFlattenedPosts)
        PostWidget(
          post: post,
          parentBangumiContentType: parentBangumiContentType,
          threadId: thread.id,
          showSpoiler: showSpoiler,
          onDeletePost: (Post post) {
            vm.deleteReply(context, post.id);
          },
          appUsername: vm.username,
          isInFlattenedReadMode: true,
        ),
    ];
  }

  List<Widget> _appBarActions(BangumiThread thread,
      BangumiContent parentBangumiContentType) {
    IconData sortIcon() {
      if (!isCupertinoPlatform()) {
        return Icons.sort_rounded;
      }

      switch (postReadMode) {
        case PostReadMode.Normal:
          return CupertinoIcons.sort_down;
        case PostReadMode.HasNewestReplyFirstNestedPost:
          return CupertinoIcons.sort_up;
        case PostReadMode.NewestFirstFlattenedPost:
        case PostReadMode.OnlySpecificPost:
        default:
          return CupertinoIcons.square_list;
      }
    }

    return [
      IconButton(
        icon: Icon(AdaptiveIcons.replyIconData),
        onPressed: () {
          if (findAppState(context)
              .currentAuthenticatedUserBasicInfo
              .avatar
              .isUsingDefaultAvatar) {
            showMuninSingleActionDialog(context,
                content: Text('你目前正在使用默认头像，'
                    '$userWithDefaultAvatarCannotPostReplyLabel'
                    '（评论会被Bangumi自动隐藏）。\n'
                    '请先在bangumi的网站里更新并上传一个任意的自定义头像。'));
            return;
          }

          showSnackBarOnSuccess(
            context,
            Navigator.push<bool>(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DiscussionReplyWidgetComposer.forCreateReply(
                      threadType:
                      ThreadType.fromBangumiContent(parentBangumiContentType),
                      threadId: thread.id,
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
      IconButton(
        icon: Icon(sortIcon()),
        onPressed: () {
          showMinHeightModalBottomSheet(context, [
            ReadModeSwitcher(
              onModeChanged: (PostReadMode newMode) {
                if (newMode != postReadMode) {
                  setState(() {
                    postReadMode = newMode;
                  });
                  scrollPrimaryScrollControllerToTop(context);
                }
                Navigator.pop(context);
              },
              currentMode: postReadMode,
            )
          ]);
        },
      ),
      MoreActions(
        parentBangumiContent: parentBangumiContentType,
        thread: thread,
        allSpoilersVisible: showSpoiler,
        toggleSpoilerCallback: toggleShowSpoiler,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
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
      onInitialBuild: (vm) {
        if (vm.thread == null) {
          requestStatusFuture = _muninRefreshKey?.currentState?.callOnRefresh();
        }
      },
      builder: (BuildContext context, _ViewModel vm) {
        final thread = vm.thread;

        if (thread == null) {
          return RequestInProgressIndicatorWidget(
            retryCallback: vm.getThread,
            requestStatusFuture: requestStatusFuture,
          );
        } else {
          final parentBangumiContentType =
              widget.request.threadType.toBangumiContent;

          Post specificPost;
          List<Widget> widgets;
          switch (postReadMode) {
            case PostReadMode.OnlySpecificPost:

            /// Try to cache the result first.
              specificPost =
                  _findPostById(widget.postId, thread.normalModePosts);
              if (specificPost == null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showTextOnSnackBar(context, '无法找到该特定回复(已被删除？)');
                });
                continue specificPostFallback;
              }
              widgets = _buildSpecificPostWidgets(
                  specificPost, vm, parentBangumiContentType);
              break;
            specificPostFallback:
            case PostReadMode.Normal:
              widgets = _buildNestedPostWidgets(
                  vm, vm.thread.normalModePosts, parentBangumiContentType);
              break;
            case PostReadMode.HasNewestReplyFirstNestedPost:
              widgets = _buildNestedPostWidgets(
                  vm,
                  vm.thread.hasNewestReplyFirstNestedPosts,
                  parentBangumiContentType);
              break;
            case PostReadMode.NewestFirstFlattenedPost:
              widgets =
                  _buildFlattenedPostWidgets(vm, parentBangumiContentType);
              break;
          }

          if (vm.thread.mainPostReplies.isEmpty) {
            widgets.add(MuninPadding(
              child: Center(
                child: Text(
                  '暂无回复',
                  style: defaultCaptionText(context),
                ),
              ),
            ));
          }

          widgets.add(Padding(padding: EdgeInsets.only(bottom: bottomOffset),));

          return MuninRefresh(
            key: _muninRefreshKey,
            onLoadMore: null,
            onRefresh: () {
              final onRefreshFuture = vm.getThread(context);
              requestStatusFuture = onRefreshFuture;
              return onRefreshFuture;
            },
            itemCount: widgets.length,
            itemBuilder: (context, index) {
              return widgets[index];
            },
            separatorBuilder: null,
            appBar: SliverAppBar(
              elevation: defaultSliverAppBarElevation,
              pinned: true,
              actions: _appBarActions(vm.thread, parentBangumiContentType),
              title: _buildAppBarTitle(
                vm.thread,
                requestStatusFuture,
              ),
            ),
            appBarUnderneathPadding: EdgeInsets.zero,
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.postId != null) {
      postReadMode = PostReadMode.OnlySpecificPost;
    }
  }
}

class _ViewModel {
  final Future<void> Function(BuildContext context) getThread;

  final void Function(BuildContext context, int replyId) deleteReply;

  final BangumiThread thread;

  final String username;

  factory _ViewModel.fromStore(Store<AppState> store, GetThreadRequest request) {
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
