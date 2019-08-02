import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/images/RoundedElevatedImage.dart';
import 'package:munin/widgets/shared/utils/common.dart';

class RoundedElevatedImageWithBottomText extends StatelessWidget {
  final String imageUrl;
  final double imageWidth;
  final double imageHeight;

  /// Used by [BangumiContent.Doujin]
  final String pageUrl;

  /// Image typically is associated with a bangumi item, and a bangumi item must
  /// have an id
  /// `id` and `contentType` together determines onTap callback of the widget
  final String id;
  final BangumiContent contentType;

  /// Title that's directly under the image
  final String title;

  /// Style of the title, default to TextTheme.caption
  final TextStyle titleStyle;
  final int titleMaxLines;

  /// Subtitle that's directly under the title
  final String subtitle;

  /// Style of the subtitle, default to TextTheme.caption
  final TextStyle subTitleStyle;
  final int subTitleMaxLines;

  /// Outer padding of this widget.
  final EdgeInsetsGeometry padding;

  const RoundedElevatedImageWithBottomText({
    Key key,
    @required this.imageUrl,
    @required this.contentType,
    @required this.id,
    this.imageWidth = 48,
    this.imageHeight = 48,
    this.title,
    this.titleStyle,
    this.titleMaxLines = 1,
    this.subtitle,
    this.subTitleStyle,
    this.subTitleMaxLines = 1,
    this.pageUrl,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
  })  : assert(imageWidth != null),
        assert(imageHeight != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> verticalItems = [
      RoundedElevatedImage.withOnTapCallBack(
        imageUrl: imageUrl,
        semanticsLabel: '图片, $title',
        imageWidth: imageWidth,
        imageHeight: imageHeight,
        imageFit: BoxFit.cover,
        cardMargin: EdgeInsets.zero,
        onTapImage: generateOnTapCallbackForBangumiContent(
            contentType: contentType,
            id: id,
            pageUrl: pageUrl,
            context: context),
      )
    ];

    if (title != null) {
      verticalItems.add(Text(
        title,
        maxLines: titleMaxLines,
        style: titleStyle ?? defaultCaptionText(context),
        overflow: TextOverflow.ellipsis,
        semanticsLabel: title,
      ));
    }

    if (subtitle != null) {
      verticalItems.add(
        Text(
          subtitle,
          style: subTitleStyle ?? defaultCaptionText(context),
          maxLines: subTitleMaxLines,
          overflow: TextOverflow.ellipsis,
          semanticsLabel: subtitle,
        ),
      );
    }

    return Padding(
      padding: padding,
      child: Container(
        /// Give text a little bit more space than image, otherwise text wraps
        /// to next line too early
        /// (I guess flutter is too conservative regarding wrapping)
        width: imageWidth * 1.05,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: verticalItems,
        ),
      ),
    );
  }
}
