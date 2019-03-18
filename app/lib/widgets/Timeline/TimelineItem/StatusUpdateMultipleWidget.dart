import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/timeline/StatusUpdateMultiple.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/HorizontalImageList.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/TimelineUserListTile.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/WrappableHyperTextLinkList.dart';

/// see [StatusUpdateMultiple] for further explanation
class StatusUpdateMultipleWidget extends StatelessWidget {
  final StatusUpdateMultiple statusUpdateMultiple;

  const StatusUpdateMultipleWidget(
      {Key key, @required this.statusUpdateMultiple})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    List<Widget> statusUpdateMultipleWidgets = [
      TimelineUserListTile(
        user: statusUpdateMultiple.user,
      ),
      WrappableHyperTextLinkList(
          hyperBangumiItems: statusUpdateMultiple.hyperBangumiItems),
    ];

    if (statusUpdateMultiple.hyperImages.length != 0) {
      statusUpdateMultipleWidgets.add(
          HorizontalImageList(hyperImages: statusUpdateMultiple.hyperImages));
    }
    return Column(
      children: statusUpdateMultipleWidgets,
    );
  }
}
