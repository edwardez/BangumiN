import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CachedRoundedCover extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  CachedRoundedCover({@required this.imageUrl, this.width, this.height});

  CachedRoundedCover.asGridSize({@required this.imageUrl})
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

//    return Image.network(imageUrl);

    /// TODO: clip is expensive, consider avoid using if there is performance issue
    return ClipRRect(
      borderRadius: new BorderRadius.circular(8.0),
      child: CachedNetworkImage(
        width: this.width,
        height: this.height,
        imageUrl: this.imageUrl,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => new Icon(Icons.error),
      ),
    );
  }
}
