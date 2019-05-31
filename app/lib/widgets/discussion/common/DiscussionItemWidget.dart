import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/discussion/DiscussionItem.dart';
import 'package:munin/models/bangumi/discussion/GroupDiscussionPost.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/shared/utils/time/TimeUtils.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';
import 'package:munin/widgets/shared/cover/CachedRoundedCover.dart';
import 'package:munin/widgets/shared/utils/common.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class DiscussionItemWidget extends StatelessWidget {
  static const titleMaxLines = 3;

  final DiscussionItem discussionItem;

  /// Checks the item is muted
  /// Currently only [GroupDiscussionPost] correctly returns its mute status
  final bool Function(DiscussionItem item) isMuted;

  /// Called when user requests a mute
  /// Currently only group discussion triggers this function
  final Function(DiscussionItem item) onMute;

  /// Called when user requests a unmute
  /// Currently only group discussion triggers this function
  final Function(DiscussionItem item) onUnmute;

  const DiscussionItemWidget({Key key,
    @required this.discussionItem,
    @required this.isMuted,
    @required this.onMute,
    @required this.onUnmute})
      : super(key: key);

  String get imageUrl {
    /// For mono, grid image is manually cropped by user which is more likely
    /// to result in a correct cropping
    if (discussionItem.bangumiContent.isMono) {
      return discussionItem.image.grid;
    }

    if (discussionItem.bangumiContent == BangumiContent.GroupTopic) {
      return discussionItem.image.large;
    }

    return discussionItem.image.medium;
  }

  GestureLongPressCallback _generateOnLongPressCallback(BuildContext context) {
    if (discussionItem is! GroupDiscussionPost) {
      return null;
    }

    Widget muteOptionWidget;
    if (isMuted(discussionItem)) {
      muteOptionWidget = ListTile(
        leading: Icon(OMIcons.clear),
        title: Text('解除屏蔽小组 ${discussionItem.subTitle}'),
        onTap: () {
          onUnmute(discussionItem);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("${discussionItem.subTitle} 将会被解除屏蔽，下次刷新数据后生效"),
          ));
          Navigator.of(context).pop();
        },
      );
    } else {
      muteOptionWidget = ListTile(
        leading: Icon(OMIcons.block),
        title: Text('屏蔽小组 ${discussionItem.subTitle}'),
        onTap: () {
          onMute(discussionItem);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("${discussionItem.subTitle} 将会被屏蔽，下次刷新数据后生效"),
          ));
          Navigator.of(context).pop();
        },
      );
    }

    return () {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SafeArea(
              child: muteOptionWidget,
            );
          });
    };
  }

  /// Calculates text scale factor for reply count so it can fit into the reply
  /// icon.
  /// Currently factor values are hard-coded, if these values are changed,
  /// [replyCountIconSize] might also need to be changed.
  double replyCountTextScaleFactor(double textScaleFactor, String text) {
    if (text.length <= 2) {
      return 1 * textScaleFactor;
    }

    if (text.length == 3) {
      return 0.85 * textScaleFactor;
    }

    return 3 / text.length * textScaleFactor;
  }

  /// Calculates size of the reply count icon.
  /// Currently factor values are hard-coded, if these values are changed,
  /// [replyCountTextScaleFactor] might also need to be changed.
  double replyCountIconSize(double textScaleFactor) {
    return defaultIconSize * 1.5 * textScaleFactor;
  }

  @override
  Widget build(BuildContext context) {
    String discussionUpdateTime = TimeUtils.formatMilliSecondsEpochTime(
        discussionItem.updatedAt,
        displayTimeIn: DisplayTimeIn.AlwaysRelative,
        fallbackTimeStr: '');
    double textScaleFactor = MediaQuery
        .of(context)
        .textScaleFactor;

    return InkWell(
      child: MuninPadding(
        child: Row(
          children: <Widget>[
            CachedRoundedCover.asGridSize(
              imageUrl: imageUrl,
            ),
            Padding(
              padding: EdgeInsets.only(left: largeOffset),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${discussionItem.subTitle}',
                      style: Theme
                          .of(context)
                          .textTheme
                          .caption,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    discussionItem.title,
                    maxLines: titleMaxLines,
                    style: Theme
                        .of(context)
                        .textTheme
                        .body2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text('$discussionUpdateTime',
                      style: Theme
                          .of(context)
                          .textTheme
                          .caption,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: largeOffset),
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Icon(
                  CupertinoIcons.conversation_bubble,
                  size: replyCountIconSize(textScaleFactor),
                ),
                Text(
                  '${discussionItem.replyCount}',
                  style: Theme
                      .of(context)
                      .textTheme
                      .body1
                      .copyWith(
                      fontSize: Theme
                          .of(context)
                          .textTheme
                          .caption
                          .fontSize),
                  textScaleFactor: replyCountTextScaleFactor(
                      textScaleFactor, '${discussionItem.replyCount}'),
                ),
              ],
            ),

          ],
        ),
      ),
      onTap: generateOnTapCallbackForBangumiContent(
          contentType: discussionItem.bangumiContent,
          id: discussionItem.id.toString(),
          context: context),
      onLongPress: _generateOnLongPressCallback(context),
    );
  }
}
