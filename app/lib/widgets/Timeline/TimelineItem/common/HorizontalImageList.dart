import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/timeline/common/HyperImage.dart';
import 'package:munin/widgets/shared/cover/CachedRoundedCover.dart';
import 'package:munin/widgets/shared/utils/common.dart';

class HorizontalImageList extends StatelessWidget {
  final BuiltList<HyperImage> hyperImages;
  final double horizontalImagePadding;

  final double imageWidth;
  final double imageHeight;

  HorizontalImageList(
      {Key key,
      @required this.hyperImages,
      this.horizontalImagePadding = 2.0,
      this.imageHeight = 48.0,
      this.imageWidth = 48.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> hyperImageWidgets = [];
    int hyperImagesCount = hyperImages.length;
    for (var i = 0; i < hyperImagesCount; i++) {
      final hyperImage = hyperImages[i];

      hyperImageWidgets.add(InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: horizontalImagePadding),
          child: CachedRoundedCover(
            imageUrl: hyperImage.imageUrl,
            width: this.imageWidth,
            height: this.imageHeight,
          ),
        ),
        onTap: generateOnTapCallbackForBangumiContent(hyperImage),
      ));
    }

    return Container(
      height: imageHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: hyperImageWidgets,
      ),
    );
  }
}
