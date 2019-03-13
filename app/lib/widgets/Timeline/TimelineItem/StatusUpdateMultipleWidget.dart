import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/timeline/StatusUpdateMultiple.dart';
import 'package:munin/models/Bangumi/timeline/common/HyperBangumiItem.dart';
import 'package:munin/models/Bangumi/timeline/common/HyperImage.dart';
import 'package:munin/widgets/Timeline/TimelineItem/common/TimelineUserListTile.dart';
import 'package:munin/widgets/shared/cover/CachedRoundedCover.dart';

/// see [StatusUpdateMultiple] for further explanation
class StatusUpdateMultipleWidget extends StatelessWidget {
  final StatusUpdateMultiple statusUpdateMultiple;

  const StatusUpdateMultipleWidget(
      {Key key, @required this.statusUpdateMultiple})
      : super(key: key);

  _concatenateItemTitle(String title, int currentIndex, int itemCount,
      {nameDelimiter = '、'}) {
    /// if it's not the last item, add a nameDelimiter
    return title + (currentIndex == itemCount - 1 ? ('') : (nameDelimiter));
  }

  _buildHyperTexts(BuiltList<HyperBangumiItem> hyperTexts, context) {
    String concatenatedText = '';
    int hyperTextsCount = hyperTexts.length;
    for (var i = 0; i < hyperTextsCount; i++) {
      final hyperText = hyperTexts[i];
      concatenatedText +=
          _concatenateItemTitle(hyperText.name, i, hyperTextsCount);
    }

    return InkWell(
      child: Row(
        children: <Widget>[
          Expanded(child: Text(concatenatedText)),
        ],
      ),
      onTap: () => {},
    );
  }

  _buildHyperImages(
    BuiltList<HyperImage> hyperImages, {
    horizontalImagePadding = 2.0,
    imageHeight = 48.0,
  }) {
    List<Widget> hyperImageWidgets = [];
    int hyperImagesCount = hyperImages.length;
    for (var i = 0; i < hyperImagesCount; i++) {
      final hyperImage = hyperImages[i];

      hyperImageWidgets.add(InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: horizontalImagePadding),
          child: CachedRoundedCover(
            imageUrl: hyperImage.imageUrl,
          ),
        ),
        onTap: () => {},
      ));
    }

    return Container(
      height: imageHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: hyperImageWidgets,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TimelineUserListTile(
          user: statusUpdateMultiple.user,
        ),
        _buildHyperTexts(statusUpdateMultiple.hyperBangumiItems, context),
        _buildHyperImages(statusUpdateMultiple.hyperImages),
      ],
    );
  }
}
