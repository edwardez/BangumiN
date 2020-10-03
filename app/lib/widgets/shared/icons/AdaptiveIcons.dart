import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

/// A set of [IconData] that has platform awareness
class AdaptiveIcons {
  static IconData get shareIconData {
    if (Platform.isIOS) {
      return CupertinoIcons.share;
    } else {
      return Icons.share;
    }
  }

  static IconData get backIconData {
    if (Platform.isIOS) {
      return CupertinoIcons.back;
    } else {
      return Icons.arrow_back;
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
      return CupertinoIcons.ellipsis;
    } else {
      return Icons.more_vert;
    }
  }

  static IconData get conversationIconData {
    if (Platform.isIOS) {
      return CupertinoIcons.chat_bubble;
    } else {
      return OMIcons.modeComment;
    }
  }

  static IconData get clipBoardIconData {
    if (Platform.isIOS) {
      return CupertinoIcons.doc_on_clipboard;
    } else {
      return Icons.content_copy;
    }
  }
}
