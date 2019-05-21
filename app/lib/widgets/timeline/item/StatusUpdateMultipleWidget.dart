import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/StatusUpdateMultiple.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/models/bangumi/timeline/common/HyperImage.dart';
import 'package:munin/widgets/shared/avatar/CachedCircleAvatar.dart';
import 'package:munin/widgets/shared/common/UserListTile.dart';
import 'package:munin/widgets/shared/images/RoundedElevatedImageWithBottomText.dart';
import 'package:munin/widgets/timeline/item/common/WrappableHyperTextLinkList.dart';

/// see [StatusUpdateMultiple] for further explanation
class StatusUpdateMultipleWidget extends StatelessWidget {
  static const double verticalImagePadding = 2.0;
  static const double horizontalImagePadding = 4.0;
  final StatusUpdateMultiple statusUpdateMultiple;

  const StatusUpdateMultipleWidget({Key key, @required this.statusUpdateMultiple})
      : super(key: key);

  List<Widget> _buildImageLists(BuiltList<HyperImage> images) {
    List<Widget> imageWidgets = [];
    if (statusUpdateMultiple.contentType == BangumiContent.User) {
      for (var image in images) {
        imageWidgets.add(Padding(
          padding: const EdgeInsets.only(right: horizontalImagePadding),
          child: CachedCircleAvatar(
            imageUrl: image.imageUrl,
            username: image.id,
            navigateToUserRouteOnTap: true,
          ),
        ));
      }
    } else {
      for (var image in images) {
        imageWidgets.add(RoundedElevatedImageWithBottomText(
          horizontalImagePadding: horizontalImagePadding,
          verticalImagePadding: verticalImagePadding,
          contentType: image.contentType,
          imageUrl: image.imageUrl,
          id: image.id,
          pageUrl: image.pageUrl,
        ));
      }
    }


    return imageWidgets;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> statusUpdateMultipleWidgets = [
      UserListTile.fromUser(
        user: statusUpdateMultiple.user,
      ),
      WrappableHyperTextLinkList(
          hyperBangumiItems: statusUpdateMultiple.hyperBangumiItems),
    ];

    if (statusUpdateMultiple.hyperImages.length != 0) {
      statusUpdateMultipleWidgets.add(
          Wrap(
            children: _buildImageLists(statusUpdateMultiple.hyperImages),
          )
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: statusUpdateMultipleWidgets,
    );
  }
}
