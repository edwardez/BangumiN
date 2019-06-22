import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/StatusUpdateMultiple.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/models/bangumi/timeline/common/HyperImage.dart';
import 'package:munin/widgets/shared/avatar/CachedCircleAvatar.dart';
import 'package:munin/widgets/shared/common/UserListTile.dart';
import 'package:munin/widgets/shared/images/RoundedElevatedImageWithBottomText.dart';
import 'package:munin/widgets/timeline/TimelineBodyWidget.dart';
import 'package:munin/widgets/timeline/item/common/FeedMoreActionsMenu.dart';
import 'package:munin/widgets/timeline/item/common/WrappableHyperTextLinkList.dart';

/// see [StatusUpdateMultiple] for further explanation
class StatusUpdateMultipleWidget extends StatelessWidget {
  static const double verticalImagePadding = 2.0;
  static const double horizontalImagePadding = 4.0;
  final DeleteFeedCallback onDeleteFeed;

  final StatusUpdateMultiple statusUpdateMultiple;

  const StatusUpdateMultipleWidget(
      {Key key,
      @required this.statusUpdateMultiple,
      @required this.onDeleteFeed})
      : super(key: key);

  List<Widget> _buildImageLists(BuiltList<HyperImage> hyperImages) {
    List<Widget> imageWidgets = [];
    if (statusUpdateMultiple.bangumiContent == BangumiContent.User) {
      for (var hyperImage in hyperImages) {
        imageWidgets.add(Padding(
          padding: const EdgeInsets.only(right: horizontalImagePadding),
          child: CachedCircleAvatar(
            imageUrl: hyperImage.image.medium,
            username: hyperImage.id,
            navigateToUserRouteOnTap: true,
          ),
        ));
      }
    } else {
      for (var hyperImage in hyperImages) {
        bool isMono = statusUpdateMultiple.bangumiContent.isMono;
        imageWidgets.add(RoundedElevatedImageWithBottomText(
          horizontalImagePadding: horizontalImagePadding,
          verticalImagePadding: verticalImagePadding,
          contentType: hyperImage.contentType,
          // for mono, grid has a correctly cropped square image
          imageUrl: isMono ? hyperImage.image.grid : hyperImage.image.medium,
          id: hyperImage.id,
          pageUrl: hyperImage.pageUrl,
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
        trailing: buildTrailingWidget(statusUpdateMultiple, onDeleteFeed),
      ),
      WrappableHyperTextLinkList(
          hyperBangumiItems: statusUpdateMultiple.hyperBangumiItems),
    ];

    if (statusUpdateMultiple.hyperImages.length != 0) {
      statusUpdateMultipleWidgets.add(Wrap(
        children: _buildImageLists(statusUpdateMultiple.hyperImages),
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: statusUpdateMultipleWidgets,
    );
  }
}
