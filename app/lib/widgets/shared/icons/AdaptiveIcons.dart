import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/widgets/shared/icons/MuninIcons.dart';

/// A set of [IconData] that has platform awareness
class AdaptiveIcons {
  static IconData get shareIconData {
    if (Platform.isIOS) {
      return MuninIcons.muninCupertinoShare;
    } else {
      return Icons.share;
    }
  }

  static IconData get backIconData {
    if (Platform.isIOS) {
      return Icons.arrow_back_ios;
    } else {
      return Icons.arrow_back;
    }
  }

  static IconData get forwardIconData {
    if (Platform.isIOS) {
      return Icons.arrow_forward_ios;
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
