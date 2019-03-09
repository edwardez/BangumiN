import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedCircleAvatar extends StatelessWidget {
  final String imageUrl;

  CachedCircleAvatar(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: this.imageUrl,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => new Icon(Icons.error),
      ),
    );
  }
}
