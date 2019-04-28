import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/discussion/DiscussionItem.dart';
import 'package:munin/shared/utils/time/TimeUtils.dart';
import 'package:munin/widgets/shared/cover/CachedRoundedCover.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';
import 'package:munin/widgets/shared/utils/common.dart';

class DiscussionItemWidget extends StatelessWidget {
  final DiscussionItem discussionItem;
  static const titleMaxLines = 2;
  static const subTitleMaxLines = 2;
  static const double smallPadding = 8.0;

  const DiscussionItemWidget({Key key, @required this.discussionItem})
      : super(key: key);

  String getImageUrl(DiscussionItem discussionItem) {
    /// For mono, grid image is manually cropped by user which is more likely
    /// to result in a correct cropping
    if (discussionItem.bangumiContent.isMono) {
      return discussionItem.images.grid;
    }

    return discussionItem.images.medium;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: smallPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CachedRoundedCover.asGridSize(
              imageUrl: getImageUrl(discussionItem),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: smallPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      maxLines: titleMaxLines,
                      text: TextSpan(children: [
                        TextSpan(
                            text: discussionItem.title,
                            style: Theme.of(context).textTheme.body1),
                        TextSpan(
                          text: ' (+${discussionItem.replyCount})',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ]),
                    ),
                    Row(
                      children: <Widget>[
                        WrappableText(
                          '${discussionItem.subTitle}',
                          textStyle: Theme.of(context).textTheme.caption,
                          fit: FlexFit.tight,
                          maxLines: subTitleMaxLines,
                        ),
                        Text(
                          TimeUtils.formatMilliSecondsEpochTime(
                              discussionItem.updatedAt,
                              displayTimeIn:
                              DisplayTimeIn.AlwaysRelative,
                              fallbackTimeStr: ''),
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: generateOnTapCallbackForBangumiContent(
          contentType: discussionItem.bangumiContent,
          id: discussionItem.id.toString(),
          context: context),
    );
  }
}
