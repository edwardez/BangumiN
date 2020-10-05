
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/shared/utils/common.dart';

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
      return Icons.mode_comment_outlined;
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

  static IconData get editIconData {
    if (isCupertinoPlatform()) {
      return CupertinoIcons.pencil;
    } else {
      return Icons.edit_rounded;
    }
  }

  static IconData get deleteIconData {
    if (isCupertinoPlatform()) {
      return CupertinoIcons.delete;
    } else {
      return Icons.delete_rounded;
    }
  }

  static IconData get warningIconData {
    if (isCupertinoPlatform()) {
      return CupertinoIcons.exclamationmark_triangle_fill;
    } else {
      return Icons.warning_rounded;
    }
  }

  static IconData get doneIconData {
    if (isCupertinoPlatform()) {
      return CupertinoIcons.checkmark_alt;
    } else {
      return Icons.done_rounded;
    }
  }

  static IconData get statisticsIconData {
    if (isCupertinoPlatform()) {
      return CupertinoIcons.chart_bar;
    } else {
      return Icons.timeline_rounded;
    }
  }

  /// TODO(edward): cupertino_icons doesn't have safari icon, figure out how to
  /// add it(copyright concern?).
  static IconData get openInBrowserIconData {
    return Icons.open_in_browser_rounded;
  }

  static IconData get muteIconData {
    if (isCupertinoPlatform()) {
      return CupertinoIcons.shield_fill;
    } else {
      return Icons.block_rounded;
    }
  }

  static IconData get unmuteIconData {
    if (isCupertinoPlatform()) {
      return CupertinoIcons.shield_slash_fill;
    } else {
      return Icons.clear_rounded;
    }
  }

  static IconData get clearIconData {
    if (isCupertinoPlatform()) {
      return CupertinoIcons.clear;
    } else {
      return Icons.clear_rounded;
    }
  }

  static IconData get addIconData {
    if (isCupertinoPlatform()) {
      return CupertinoIcons.add;
    } else {
      return Icons.add_rounded;
    }
  }

  static IconData get questionCircleIconData {
    if (isCupertinoPlatform()) {
      return CupertinoIcons.question_circle;
    } else {
      return Icons.help_outline_rounded;
    }
  }

  static IconData get visibilityOffIconData {
    if (isCupertinoPlatform()) {
      return CupertinoIcons.eye_slash;
    } else {
      return Icons.visibility_off_rounded;
    }
  }

  static IconData get visibilityOnIconData {
    if (isCupertinoPlatform()) {
      return CupertinoIcons.eye;
    } else {
      return Icons.visibility_rounded;
    }
  }
}
