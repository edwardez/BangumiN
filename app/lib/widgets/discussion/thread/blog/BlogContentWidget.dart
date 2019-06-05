import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/discussion/thread/blog/BlogContent.dart';
import 'package:munin/shared/utils/time/TimeUtils.dart';
import 'package:munin/widgets/discussion/thread/shared/CopyPostContent.dart';
import 'package:munin/widgets/discussion/thread/shared/UserWithPostContent.dart';
import 'package:munin/widgets/shared/bottomsheet/showMinHeightModalBottomSheet.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';

class BlogContentWidget extends StatelessWidget {
  final BlogContent blogContent;

  const BlogContentWidget({Key key, @required this.blogContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MuninPadding(
      child: UserWithPostContent(
        showSpoiler: false,
        onTapMoreActionsIcon: () {
          showMinHeightModalBottomSheet(
            context,
            [
              CopyPostContent(
                contentHtml: blogContent.html,
                contextWithScaffold: context,
              ),
            ],
          );
        },
        alignPostContentWithAvatar: true,
        attachTopDivider: false,
        trailingStringAfterUsername: TimeUtils.formatMilliSecondsEpochTime(
          blogContent.postTimeInMilliSeconds,
          displayTimeIn: DisplayTimeIn.AlwaysAbsolute,
        ),
        contentHtml: blogContent.html,
        author: blogContent.author,
      ),
    );
  }
}
