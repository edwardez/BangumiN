import 'package:flutter/material.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';
import 'package:munin/widgets/shared/text/editor/sticker/BangumiStickers.dart';

showBangumiStickersBottomSheet(
    BuildContext context, Function(int id) onStickerTapped) {
  return showModalBottomSheet(
      context: context,
      builder: (innerContext) {
        return ListView(
          children: <Widget>[
            ListTile(
              title: Text('插入一个表情'),
            ),
            MuninPadding.vertical1xOffset(
              child: BangumiStickers(onStickerTapped: onStickerTapped),
              denseHorizontal: true,
            )
          ],
        );
      });
}
