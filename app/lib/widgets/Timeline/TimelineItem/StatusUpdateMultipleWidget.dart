import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/timeline/StatusUpdateMultiple.dart';
import 'package:munin/models/Bangumi/timeline/common/HyperImage.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/TimelineUserListTile.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/WrappableHyperTextLinkList.dart';
import 'package:munin/widgets/shared/common/HorizontalScrollableWidget.dart';
import 'package:munin/widgets/shared/images/RoundedImageWithVerticalText.dart';

/// see [StatusUpdateMultiple] for further explanation
class StatusUpdateMultipleWidget extends StatelessWidget {
  final StatusUpdateMultiple statusUpdateMultiple;

  const StatusUpdateMultipleWidget({Key key, @required this.statusUpdateMultiple})
      : super(key: key);

  _buildImageLists(BuiltList<HyperImage> images) {
    List<RoundedImageWithVerticalText> imageWidgets = [];
    for (var image in images) {
      imageWidgets.add(RoundedImageWithVerticalText(
        contentType: image.contentType,
        imageUrl: image.imageUrl,
        id: image.id,
        pageUrl: image.pageUrl,
        totalWidthFactor: 1,
      ));
    }

    return imageWidgets;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> statusUpdateMultipleWidgets = [
      TimelineUserListTile.fromUser(
        user: statusUpdateMultiple.user,
      ),
      WrappableHyperTextLinkList(
          hyperBangumiItems: statusUpdateMultiple.hyperBangumiItems),
    ];

    if (statusUpdateMultiple.hyperImages.length != 0) {
      statusUpdateMultipleWidgets.add(HorizontalScrollableWidget(
        horizontalList: _buildImageLists(statusUpdateMultiple.hyperImages),
        listHeight: 48.0,
      ));
    }
    return Column(
      children: statusUpdateMultipleWidgets,
    );
  }
}
