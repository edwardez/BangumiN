import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/discussion/thread/common/OriginalPost.dart';
import 'package:munin/models/bangumi/discussion/thread/common/Post.dart';
import 'package:munin/models/bangumi/discussion/thread/post/MainPostReply.dart';
import 'package:munin/models/bangumi/discussion/thread/post/SubPostReply.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/shared/utils/time/TimeUtils.dart';
import 'package:munin/widgets/discussion/thread/shared/CopyPostContent.dart';
import 'package:munin/widgets/discussion/thread/shared/UserWithPostContent.dart';
import 'package:munin/widgets/shared/bottomsheet/showMinHeightModalBottomSheet.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';
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

  const PostWidget({
    Key key,
    @required this.post,
    @required this.threadId,
    @required this.parentBangumiContentType,
    this.showSpoiler = false,
  }) : super(key: key);

  String get postSequentialNameAndTime {
    String result = '';
    result += '${post.sequentialName} / ';

    result += TimeUtils.formatMilliSecondsEpochTime(post.postTimeInMilliSeconds,
        displayTimeIn: DisplayTimeIn.AlwaysAbsolute);
    return result;
  }

  _showMoreActionsBottomSheet(
    BuildContext context,
  ) {
    showMinHeightModalBottomSheet(
      context,
      [
        CopyPostContent(
          contentHtml: post.contentHtml,
          contextWithScaffold: context,
        ),
        if (post is! OriginalPost)
          ListTile(
            leading: Icon(Icons.content_copy),
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
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('当前无法复制楼层链接'),
                ));
              }
            },
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body = UserWithPostContent(
      showSpoiler: false,
      onTapMoreActionsIcon: () {
        _showMoreActionsBottomSheet(context);
      },
      alignPostContentWithAvatar: post is OriginalPost,
      attachTopDivider: post is! OriginalPost,
      trailingStringAfterUsername: postSequentialNameAndTime,
      contentHtml: post.contentHtml,
      author: post.author,
    );

    if (post is SubPostReply) {
      return MuninPadding.vertical1xOffset(
        child: Padding(
          padding: EdgeInsets.only(left: UserWithPostContent.avatarRadius),
          child: body,
        ),
      );
    }

    return MuninPadding.vertical1xOffset(
      child: body,
    );
  }
}
