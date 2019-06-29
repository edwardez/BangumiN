import 'package:flutter/material.dart';
import 'package:munin/widgets/shared/text/editor/sticker/BangumiSticker.dart';

class BangumiStickers extends StatelessWidget {
  static const minId = 1;
  static const maxId = 123;

  /// A callback function that's called when a specific sticker is tapped.
  final Function(int id) onStickerTapped;

  const BangumiStickers({
    Key key,
    this.onStickerTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).textScaleFactor;

    return Wrap(
      children: <Widget>[
        for (var i = minId; i < maxId; i++)
          InkWell(
            child: BangumiSticker(
              id: i,
              scaleFactor: scaleFactor,
            ),
            onTap: () {
              if (onStickerTapped != null) {
                onStickerTapped(i);
              }
            },
          )
      ],
    );
  }
}
