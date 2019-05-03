import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/widgets/shared/utils/common.dart';
import 'package:quiver/strings.dart';
import 'package:transparent_image/transparent_image.dart';


class CachedCircleAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;

  /// Default to true, user will be redirected to relevant bangumi user route if taps
  /// If set to false. This widget will be a pure circle avatar widget
  final bool navigateToUserRouteOnTap;

  /// if [navigateToUserRouteOnTap] is set to true, [username] cannot be null
  final String username;

  CachedCircleAvatar({@required this.imageUrl, this.radius = 20.0,
    this.navigateToUserRouteOnTap = false, this.username})
      : assert(!navigateToUserRouteOnTap ||
      (navigateToUserRouteOnTap && isNotEmpty(username)));

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

    CircleAvatar avatar = CircleAvatar(
      radius: this.radius,
      backgroundColor: Colors.transparent,
      backgroundImage: CachedNetworkImageProvider(this.imageUrl),
    );

    if (!navigateToUserRouteOnTap) {
      return avatar;
    }

    return InkWell(
      child: avatar,
      onTap: generateOnTapCallbackForBangumiContent(
          contentType: BangumiContent.User,
          id: username,
          context: context
      ),
    );
  }
}
