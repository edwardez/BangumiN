import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/common/HyperBangumiItem.dart';
import 'package:munin/widgets/shared/utils/common.dart';

class WrappableHyperTextLinkList extends StatelessWidget {
  static const nameDelimiter = '、';

  final BuiltList<HyperBangumiItem> hyperBangumiItems;
  final double verticalPadding;
  final int subjectNameMaxLines;

  const WrappableHyperTextLinkList(
      {Key key,
      @required this.hyperBangumiItems,
      this.verticalPadding = 4.0,
      this.subjectNameMaxLines = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ;
    int hyperTextsCount = hyperBangumiItems.length;

    List<Widget> children = [];

    for (var i = 0; i < hyperTextsCount; i++) {
      final hyperBangumiItem = hyperBangumiItems[i];
      children.add(InkWell(
        child: Text(hyperBangumiItem.name),
        onTap: generateOnTapCallbackForBangumiContent(
            contentType: hyperBangumiItem.contentType,
            id: hyperBangumiItem.id,
            context: context,
            pageUrl: hyperBangumiItem.pageUrl),
      ));

      final bool isNotLastItem = i != hyperTextsCount - 1;
      if (isNotLastItem) {
        children.add(Text(nameDelimiter));
      }
    }

    return Container(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        child: Wrap(
          children: children,
        ));
  }
}
