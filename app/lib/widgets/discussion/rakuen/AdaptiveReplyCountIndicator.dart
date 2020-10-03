import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/icons/MuninIcons.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

/// An adaptive indicator that displays number of replies.
/// On [Platform.isAndroid], it's an android-style conversation icon, with reply
/// count in the bottom.
/// On other platforms, it's an iOS-style conversation icon, with reply count
/// in the center of the icon. Size of reply count changes according to current
/// text scale factor and text size.
class AdaptiveReplyCountIndicator extends StatelessWidget {
  static const maxDisplayableReplyCount = 9999;

  final int replyCount;

  const AdaptiveReplyCountIndicator({Key key, @required this.replyCount})
      : assert(replyCount != null),
        super(key: key);

  /// Displays full reply count if it's less than or equals to [maxDisplayableReplyCount],
  /// Other wise displays a clipped `$maxDisplayableReplyCount+`.
  String get clippedReplyCountText {
    if (replyCount <= maxDisplayableReplyCount) {
      return replyCount.toString();
    }

    return '$maxDisplayableReplyCount+';
  }

  /// Calculates text scale factor for reply count so it can fit into the reply
  /// icon.
  /// Currently factor values are hard-coded, if these values are changed,
  /// [replyCountIconSize] might also need to be changed.
  double replyCountTextScaleFactor(double textScaleFactor, String text) {
    if (text.length <= 2) {
      return 1 * textScaleFactor;
    }

    if (text.length == 3) {
      return 0.85 * textScaleFactor;
    }

    return 3 / text.length * textScaleFactor;
  }

  /// Calculates size of the reply count icon.
  /// Currently factor values are hard-coded, if these values are changed,
  /// [replyCountTextScaleFactor] might also need to be changed.
  double replyCountIconSize(double textScaleFactor) {
    return defaultIconSize * 1.5 * textScaleFactor;
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Column(
        children: <Widget>[
          Icon(OMIcons.modeComment),
          Text(clippedReplyCountText)
        ],
      );
    }

    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Icon(
          MuninIcons.muninCupertinoChatBubble,
          size: replyCountIconSize(textScaleFactor),
        ),
        Text(
          clippedReplyCountText,
          style: Theme.of(context)
              .textTheme
              .body1
              .copyWith(fontSize: Theme.of(context).textTheme.caption.fontSize),
          textScaleFactor:
              replyCountTextScaleFactor(textScaleFactor, clippedReplyCountText),
        ),
      ],
    );
  }
}
