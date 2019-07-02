import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/text/editor/sticker/utils.dart';

class BangumiSticker extends StatelessWidget {
  final int id;

  final EdgeInsets padding;

  /// The sticker icon size, if set to null, original image size will be used.
  final double stickerSize;

  /// Scale factor of the icon. It's mainly used for accessibility purpose.
  /// Setting it to null results in querying [MediaQuery.of(context).textScaleFactor].
  final double scaleFactor;

  /// How to inscribe the image into the space allocated during layout.
  ///
  /// The default is [BoxFit.contain].
  final BoxFit fit;

  const BangumiSticker({
    Key key,
    @required this.id,
    this.padding = const EdgeInsets.all(mediumOffset),
    this.stickerSize,
    this.scaleFactor,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scale = scaleFactor ?? MediaQuery.of(context).textScaleFactor;

    return Padding(
      padding: padding,
      child: Image.asset(
        'assets/stickers/bangumi/${idToFullFileName(id)}',
        scale: scale,
        width: stickerSize,
        height: stickerSize,
        fit: BoxFit.contain,
      ),
    );
  }
}
