import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/discussion/thread/post/MainPostReply.dart';
import 'package:munin/models/bangumi/discussion/thread/post/SubPostReply.dart';
import 'package:munin/styles/theme/Common.dart';

enum PostReadMode {
  /// The classic mode, same as bangumi: all post are displayed in chronological
  /// order and there are nested post.
  Normal,

  /// Posts are displayed in reversed order, a [MainPostReply] that has a newer
  /// [SubPostReply] will be displayed first, if it doesn't has a [SubPostReply].
  /// Post time of [MainPostReply] will be used.
  HasNewestReplyFirstNestedPost,

  /// Posts are displayed in reversed order, and nested posts are flattened.
  NewestFirstFlattenedPost,

  /// Only a specific post is displayed.
  OnlySpecificPost,
}

/// A switcher that let user chooses between different modes
class ReadModeSwitcher extends StatelessWidget {
  final PostReadMode currentMode;

  final void Function(PostReadMode newMode) onModeChanged;

  const ReadModeSwitcher({
    Key key,
    @required this.currentMode,
    @required this.onModeChanged,
  }) : super(key: key);

  TextStyle optionTitleStyle(BuildContext context, PostReadMode option) {
    if (option == currentMode) {
      final selectedColor = lightPrimaryDarkAccentColor(context);
      return TextStyle(color: selectedColor);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text(
            '从旧到新',
            style: optionTitleStyle(context, PostReadMode.Normal),
          ),
          subtitle: Text('Bangumi默认模式'),
          onTap: () {
            onModeChanged(PostReadMode.Normal);
          },
        ),
        ListTile(
          title: Text(
            '从新到旧',
            style: optionTitleStyle(
                context, PostReadMode.HasNewestReplyFirstNestedPost),
          ),
          subtitle: Text('有新回复的主楼层在最前面'),
          onTap: () {
            onModeChanged(PostReadMode.HasNewestReplyFirstNestedPost);
          },
        ),
        ListTile(
          title: Text(
            '从新到旧',
            style: optionTitleStyle(
                context, PostReadMode.NewestFirstFlattenedPost),
          ),
          subtitle: Text('平铺所有回复'),
          onTap: () {
            onModeChanged(PostReadMode.NewestFirstFlattenedPost);
          },
        ),
      ],
    );
  }
}
