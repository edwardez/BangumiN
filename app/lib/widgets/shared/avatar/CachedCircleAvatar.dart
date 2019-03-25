import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CachedCircleAvatar extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  CachedCircleAvatar(
      {@required this.imageUrl, this.width = 40.0, this.height = 40.0});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return Image.memory(
        kTransparentImage,
        semanticLabel: '用户头像',
        width: width,
        height: height,
      );
    }
//    return Image.network(imageUrl);

    /// TODO: clip is expensive, consider avoid using if there is performance issue
    return ClipOval(
      child: CachedNetworkImage(
        width: this.width,
        height: this.height,
        imageUrl: this.imageUrl,
        fit: BoxFit.contain,
        errorWidget: (context, url, error) => new Icon(Icons.error),
      ),
    );
  }
}
