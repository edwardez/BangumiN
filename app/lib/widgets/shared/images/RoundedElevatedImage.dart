import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/common/Images.dart';

/// a subject cover
class RoundedElevatedImage extends StatelessWidget {
  final String imageUrl;

  /// if [imageUrl] is null, [fallbackImageUrl] will be used
  /// default to [Images.defaultCoverImage]
  final String fallbackImageUrl;

  final double imageWidth;
  final double imageHeight;
  final Color borderColor;
  final double borderWidth;
  final double elevation;
  final double borderRadius;

  const RoundedElevatedImage(
      {Key key,
      @required this.imageUrl,
        this.fallbackImageUrl = Images.defaultCoverImage,
      this.borderColor = Colors.black12,
      this.borderWidth = 0.5,
      this.elevation = 1.5,
      this.borderRadius = 4.0,
      this.imageWidth,
      this.imageHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor, width: borderWidth),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        elevation: elevation,
        child: CachedNetworkImage(

          imageUrl: imageUrl ?? fallbackImageUrl,
          height: imageHeight,
          width: imageWidth,
        ),
        clipBehavior: Clip.hardEdge,
      ),
    );
  }
}
