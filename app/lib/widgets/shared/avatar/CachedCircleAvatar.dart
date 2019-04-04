import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CachedCircleAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;

  CachedCircleAvatar({@required this.imageUrl, this.radius = 20.0});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return Image.memory(
        kTransparentImage,
        semanticLabel: '用户头像',
        width: radius * 2,
        height: radius * 2,
      );
    }

    return CircleAvatar(
      radius: this.radius,
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      backgroundImage: CachedNetworkImageProvider(this.imageUrl),
    );
  }
}
