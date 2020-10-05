import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/discussion/thread/common/OriginalPost.dart';
import 'package:munin/models/bangumi/discussion/thread/common/Post.dart';
import 'package:munin/models/bangumi/discussion/thread/common/ThreadType.dart';
import 'package:munin/models/bangumi/discussion/thread/post/MainPostReply.dart';
import 'package:munin/models/bangumi/discussion/thread/post/SubPostReply.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/redux/shared/utils.dart';
import 'package:munin/shared/utils/time/TimeUtils.dart';
import 'package:munin/widgets/discussion/common/DiscussionReplyWidgetComposer.dart';
import 'package:munin/widgets/discussion/thread/shared/Constants.dart';
import 'package:munin/widgets/discussion/thread/shared/CopyPostContent.dart';
import 'package:munin/widgets/discussion/thread/shared/PostEditor.dart';
import 'package:munin/widgets/discussion/thread/shared/UserWithPostContent.dart';
import 'package:munin/widgets/shared/bottomsheet/showMinHeightModalBottomSheet.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';
import 'package:munin/widgets/shared/common/SnackBar.dart';
import 'package:munin/widgets/shared/dialog/common.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';
import 'package:munin/widgets/shared/services/Clipboard.dart';
import 'package:munin/widgets/shared/utils/common.dart';

class PostWidget extends StatelessWidget {
  /// Parent thread id that this post belongs to.
  final int threadId;

  /// Post data model. A [post] can be a
  /// [InitialGroupPost] or [MainPostReply] or [SubPostReply].
  /// If it's a [InitialGroupPost]. Text will be aligned with avatar and divider won't be
  /// attached to the top.
  /// If it's a [SubPostReply]. A dense padding will be used: Widget will be
  /// moved to right for [avatarRadius], there will be no left padding.
  final Post post;

  final bool showSpoiler;

  /// The parent bangumi content that this post belongs to.
  final BangumiContent parentBangumiContentType;

  /// Callback function that'll be executed when user request deletes this
  /// reply.
  final Function(Post post) onDeletePost;

  /// User name of the user who is using the app.
  final String appUsername;

  /// Whether post is in flattened read mode, a left padding should be added to
  /// sub posts such as [SubPostReply] if this is set to false.
  ///
  /// Default to false.
  final bool isInFlattenedReadMode;

  const PostWidget({
    Key key,
    @required this.post,
    @required this.threadId,
    @required this.parentBangumiContentType,
    @required this.onDeletePost,
    @required this.appUsername,
    this.showSpoiler = false,
    this.isInFlattenedReadMode = false,
  }) : super(key: key);

  String get postSequentialNameAndTime {
    String result = '';
    result += '${post.sequentialName} / ';

    result += TimeUtils.formatMilliSecondsEpochTime(post.postTimeInMilliSeconds,
        displayTimeIn: DisplayTimeIn.AlwaysAbsolute);
    return result;
  }

  _buildEditReplyWidget(BuildContext context) {
    bool shouldDisableEdit =
        post is MainPostReply && (post as MainPostReply).subReplies.isNotEmpty;

    return ListTile(
      leading: Icon(AdaptiveIcons.editIconData),
      title: Text(
        '编辑此回复',
      ),
      subtitle: shouldDisableEdit
          ? Text(
        '已有回复的楼层无法编辑',
      )
          : null,
      onTap: shouldDisableEdit
          ? null
          : () async {
        Navigator.pop(context);
        showSnackBarOnSuccess(context, Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PostEditor(
                    threadType: ThreadType.fromBangumiContent(
                        parentBangumiContentType),
                    replyId: post.id,
                    threadId: threadId,
                  )),
        ), '回复编辑成功');
      },
      enabled: !shouldDisableEdit,
    );
  }

  _buildDeleteReplyWidget(BuildContext context) {
    bool shouldDisableDelete =
        post is MainPostReply && (post as MainPostReply).subReplies.isNotEmpty;

    return ListTile(
      leading: Icon(AdaptiveIcons.deleteIconData),
      title: Text(
        '删除此回复',
      ),
      subtitle: shouldDisableDelete
          ? Text(
        '已有回复的楼层无法删除',
      )
          : null,
      onTap: shouldDisableDelete
          ? null
          : () async {
        Navigator.pop(context);

        final confirmation = await showMuninYesNoDialog(
          context,
          title: Text('确认删除此回复？'),
          content: Text('删除后将不可恢复'),
          cancelAction: Text('取消'),
          confirmAction: Text('确认删除'),
        );
        if (confirmation == true) {
          onDeletePost(post);
        }
      },
      enabled: !shouldDisableDelete,
    );
  }

  _showMoreActionsBottomSheet(BuildContext context,) {
    Widget _buildReplyOption() {
      const replyLabel = '回复';
      if (findAppState(context)
          .currentAuthenticatedUserBasicInfo
          .avatar
          .isUsingDefaultAvatar) {
        return ListTile(
          leading: Icon(AdaptiveIcons.replyIconData),
          title: Text(
            replyLabel,
          ),
          subtitle: Text(
            userWithDefaultAvatarCannotPostReplyLabel,
          ),
          enabled: false,
        );
      }

      return ListTile(
        leading: Icon(AdaptiveIcons.replyIconData),
        title: Text(replyLabel),
        onTap: () async {
          Navigator.pop(context);

          showSnackBarOnSuccess(
            context,
            Navigator.push<bool>(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DiscussionReplyWidgetComposer.forCreateReply(
                      threadType:
                      ThreadType.fromBangumiContent(parentBangumiContentType),
                      targetPost: post,
                      threadId: threadId,
                    ),
              ),
            ),
            '$replyLabel成功',
          );
        },
      );
    }

    showMinHeightModalBottomSheet(
      context,
      [
        CopyPostContent(
          contentHtml: post.contentHtml,
          contextWithScaffold: context,
        ),
        if (post is! OriginalPost)
          ListTile(
            leading: Icon(AdaptiveIcons.clipBoardIconData),
            title: Text('复制楼层链接'),
            onTap: () {
              Navigator.pop(context);
              String postContent;

              generateWebPageUrlByContentType(
                      parentBangumiContentType, threadId.toString())
                  .ifPresent((pageUrl) {
                // Bangumi url format to navigate to a specific post.
                // [InitialGroupPost] cannot be navigated like this.
                postContent = '$pageUrl#post_${post.id}';
              });

              if (postContent != null) {
                ClipboardService.copyAsPlainText(context, postContent);
              } else {
                showTextOnSnackBar(context, '当前无法复制楼层链接');
              }
            },
          ),
        _buildReplyOption(),
        // Disable deleting thread for now as it's not a critical feature
        // and we lack a good way to test it.
        if (appUsername == post.author.username && post is! OriginalPost) ...[
          _buildEditReplyWidget(context),
          _buildDeleteReplyWidget(context),
        ]
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body = UserWithPostContent(
      showSpoiler: showSpoiler,
      onTapMoreActionsIcon: () {
        _showMoreActionsBottomSheet(context);
      },
      alignPostContentWithAvatar: post is OriginalPost,
      attachTopDivider: post is! OriginalPost,
      trailingStringAfterUsername: postSequentialNameAndTime,
      contentHtml: post.contentHtml,
      author: post.author,
    );

    if (post is SubPostReply && !isInFlattenedReadMode) {
      return MuninPadding.vertical1xOffset(
        child: Padding(
          padding: EdgeInsets.only(left: UserWithPostContent.avatarRadius * 2),
          child: body,
        ),
      );
    }

    return MuninPadding.vertical1xOffset(
      child: body,
    );
  }
}
