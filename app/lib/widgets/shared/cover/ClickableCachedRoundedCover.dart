import 'package:flutter/material.dart';
import 'package:munin/widgets/shared/cover/CachedRoundedCover.dart';

enum CoverLinkType { subject, user, person, character }

class ClickableCachedRoundedCover extends StatelessWidget {
  final String imageUrl;
  final int id;
  final double width;
  final CoverLinkType coverLinkType;

  ClickableCachedRoundedCover.name(
      {@required this.imageUrl,
      @required this.coverLinkType,
        @required this.width,
        @required this.height,
      this.id});

  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: CachedRoundedCover(
          imageUrl: this.imageUrl, width: this.width, height: this.height),
      onTap: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (_) => null,
          )),
    );
  }
}
