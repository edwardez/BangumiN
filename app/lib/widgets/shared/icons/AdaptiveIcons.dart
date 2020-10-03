
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

/// A set of [IconData] that has platform awareness
class AdaptiveIcons {
  static IconData get shareIconData {
    if (isCupertinoPlatform()) {
      return CupertinoIcons.share;
    } else {
      return Icons.share;
    }
  }

  static IconData get backIconData {
    if (isCupertinoPlatform()) {
      return CupertinoIcons.back;
    } else {
      return Icons.arrow_back;
    }
  }

  static IconData get forwardIconData {
    if (isCupertinoPlatform()) {
      return CupertinoIcons.forward;
    } else {
      return Icons.arrow_forward;
    }
  }

  static IconData get moreActionsIconData {
    if (isCupertinoPlatform()) {
      return CupertinoIcons.ellipsis;
    } else {
      return Icons.more_vert;
    }
  }

  static IconData get conversationIconData {
    if (isCupertinoPlatform()) {
      return CupertinoIcons.chat_bubble;
    } else {
      return OMIcons.modeComment;
    }
  }

  static IconData get clipBoardIconData {
    if (isCupertinoPlatform()) {
      return CupertinoIcons.doc_on_clipboard;
    } else {
      return Icons.content_copy;
    }
  }

  static IconData get replyIconData {
    if (isCupertinoPlatform()) {
      return CupertinoIcons.reply;
    } else {
      return Icons.reply_outlined;
    }
  }

  static IconData get sortDownIconData {
    if (isCupertinoPlatform()) {
      return CupertinoIcons.sort_down;
    } else {
      return Icons.sort_rounded;
    }
  }
}
