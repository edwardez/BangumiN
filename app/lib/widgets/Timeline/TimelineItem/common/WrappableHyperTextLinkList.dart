import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/timeline/common/HyperBangumiItem.dart';

class WrappableHyperTextLinkList extends StatelessWidget {
  final BuiltList<HyperBangumiItem> hyperBangumiItems;
  final double verticalPadding;
  final int subjectNameMaxLines;

  const WrappableHyperTextLinkList(
      {Key key,
      @required this.hyperBangumiItems,
      this.verticalPadding = 4.0,
      this.subjectNameMaxLines = 30})
      : super(key: key);

  _concatenateItemTitle(String title, int currentIndex, int itemCount,
      {nameDelimiter = '、'}) {
    /// if it's not the last item, add a nameDelimiter
    return title + (currentIndex == itemCount - 1 ? ('') : (nameDelimiter));
  }

  @override
  Widget build(BuildContext context) {
    String concatenatedText = '';
    int hyperTextsCount = hyperBangumiItems.length;
    for (var i = 0; i < hyperTextsCount; i++) {
      final hyperText = hyperBangumiItems[i];
      concatenatedText +=
          _concatenateItemTitle(hyperText.name, i, hyperTextsCount);
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: InkWell(
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              concatenatedText,
              maxLines: subjectNameMaxLines,
              overflow: TextOverflow.ellipsis,
            )),
          ],
        ),
        onTap: () => {},
      ),
    );
  }
}
