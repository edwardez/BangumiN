import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/widgets/shared/cover/CachedRoundedCover.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';
import 'package:munin/widgets/shared/utils/common.dart';

class RoundedImageWithVerticalText extends StatelessWidget {
  final double imageWidth;
  final double widgetWidth;
  final double imageHeight;
  final double horizontalImagePadding;
  final String imageUrl;
  final String pageUrl;
  final String id;
  final String title;
  final int titleMaxLines;
  final int subTitleMaxLines;
  final String subtitle;
  final BangumiContent contentType;

  const RoundedImageWithVerticalText({
    Key key,
    @required this.imageUrl,
    @required this.contentType,
    @required this.id,
    this.imageWidth = 48,
    this.imageHeight = 48,
    this.title,
    this.subtitle,
    this.horizontalImagePadding = 2,
    this.pageUrl,
    this.titleMaxLines = 1,
    this.subTitleMaxLines = 1,
    totalWidthFactor = 1.5,
  })  : this.widgetWidth = imageWidth * totalWidthFactor,
        assert(imageWidth != null),
        assert(imageHeight != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> verticalItems = [
      CachedRoundedCover(
        imageUrl: imageUrl,
        width: this.imageWidth,
        height: this.imageHeight,
      )
    ];

    if (title != null) {
      verticalItems.add(
        WrappableText(
          title,
          maxLines: titleMaxLines,
        ),
      );
    }

    if (subtitle != null) {
      verticalItems.add(
        WrappableText(
          subtitle,
          textStyle: Theme.of(context).textTheme.caption,
          maxLines: subTitleMaxLines,
        ),
      );
    }

    return InkWell(
      child: Container(
        width: widgetWidth,
        padding: EdgeInsets.symmetric(horizontal: horizontalImagePadding),
        child: Column(
          children: verticalItems,
        ),
      ),
      onTap: generateOnTapCallbackForBangumiContent(
          contentType: contentType, id: id, pageUrl: pageUrl, context: context),
    );
  }
}
