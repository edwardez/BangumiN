import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:transparent_image/transparent_image.dart';

class CachedRoundedCover extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BorderRadiusGeometry borderRadius;

  CachedRoundedCover(
      {@required this.imageUrl,
      @required this.width,
      @required this.height,
      this.borderRadius =
          const BorderRadius.all(Radius.circular(defaultImageCircularRadius))});

  CachedRoundedCover.asGridSize(
      {@required this.imageUrl,
      this.borderRadius =
          const BorderRadius.all(Radius.circular(defaultImageCircularRadius))})
      : this.width = 48,
        this.height = 48;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return Image.memory(
        kTransparentImage,
        semanticLabel: '封面图',
        width: width,
        height: height,
      );
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(imageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: borderRadius,
      ),
      width: width,
      height: height,
    );
  }
}
