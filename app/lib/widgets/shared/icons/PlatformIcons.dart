import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/widgets/shared/icons/MuninIcons.dart';

/// A set of [IconData] that has platform awareness
class PlatformIcons {
  static IconData get shareIconData {
    if (Platform.isIOS) {
      return MuninIcons.muninCupertinoShare;
    } else {
      return Icons.share;
    }
  }

  static IconData get forwardIconData {
    if (Platform.isIOS) {
      return CupertinoIcons.forward;
    } else {
      return Icons.arrow_forward;
    }
  }

  static IconData get moreActionsIconData {
    if (Platform.isIOS) {
      return Icons.more_horiz;
    } else {
      return Icons.more_vert;
    }
  }
}
