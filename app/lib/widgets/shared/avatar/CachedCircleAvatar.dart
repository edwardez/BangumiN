import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:munin/shared/utils/common.dart';

class CachedCircleAvatar extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  CachedCircleAvatar({@required this.imageUrl, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        width: this.width,
        height: this.height,
        imageUrl: upgradeToHttps(this.imageUrl),
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => new Icon(Icons.error),
      ),
    );
  }
}
