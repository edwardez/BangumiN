import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';

/// a subject cover
class RoundedElevatedImage extends StatelessWidget {
  final String imageUrl;

  /// if [imageUrl] is null, [fallbackImageUrl] will be used
  /// default to [BangumiImage.defaultCoverImage]
  final String fallbackImageUrl;

  final double imageWidth;
  final double imageHeight;
  final double elevation;

  final BoxFit imageFit;

  /// Semantics label of this image
  final String semanticsLabel;

  final GestureTapCallback onTapImage;

  final EdgeInsetsGeometry cardMargin;

  const RoundedElevatedImage({
    Key key,
    @required this.imageUrl,
    this.fallbackImageUrl = BangumiImage.defaultCoverImage,
    this.elevation = 1.0,
    this.imageWidth,
    this.imageHeight,
    this.imageFit,
    this.semanticsLabel, this.cardMargin,
  })
      : this.onTapImage = null,
        super(key: key);

  /// If a callback needs to be added to the image, it's mandatory to specify
  /// imageWidth and imageHeight, otherwise image won't be displayed
  /// (might be a bug in flutter?)
  const RoundedElevatedImage.withOnTapCallBack({
    Key key,
    @required this.imageUrl,
    @required this.onTapImage,
    @required this.imageWidth,
    @required this.imageHeight,
    this.fallbackImageUrl = BangumiImage.defaultCoverImage,
    this.elevation = 1.0,
    this.imageFit,
    this.semanticsLabel, this.cardMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget image;
    if (onTapImage == null) {
      image = Card(
        margin: cardMargin,
        elevation: elevation,
        child: CachedNetworkImage(
          imageUrl: imageUrl ?? fallbackImageUrl,
          width: imageWidth,
          height: imageHeight,
          fit: imageFit,
        ),
        clipBehavior: Clip.antiAlias,
      );
    } else {
      image = Card(
        margin: cardMargin,
        elevation: elevation,
        child: InkWell(
          child: Ink.image(
            image: CachedNetworkImageProvider(
              imageUrl ?? fallbackImageUrl,
            ),
            child: Container(
              width: imageWidth,
              height: imageHeight,
            ),
            fit: imageFit,
          ),
          onTap: onTapImage,
        ),
        clipBehavior: Clip.antiAlias,
      );
    }

    if (semanticsLabel != null) {
      return Semantics(
        child: image,
        label: semanticsLabel,
      );
    }

    return image;
  }
}
