import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/widgets/shared/cover/CachedRoundedCover.dart';
import 'package:munin/widgets/shared/utils/common.dart';

class ClickableCachedRoundedCover extends StatelessWidget {
  final String imageUrl;
  final String id;
  final double width;
  final double height;
  final BangumiContent contentType;

  ClickableCachedRoundedCover(
      {@required this.imageUrl,
      @required this.contentType,
      @required this.width,
      @required this.height,
      @required this.id});

  ClickableCachedRoundedCover.asGridSize({
    @required this.imageUrl,
    @required this.contentType,
    @required this.id,
    this.width = 48.0,
    this.height = 48.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: CachedRoundedCover(
          imageUrl: this.imageUrl, width: this.width, height: this.height),
      onTap: generateOnTapCallbackForBangumiContent(
          contentType: contentType, id: id, context: context),
    );
  }
}
