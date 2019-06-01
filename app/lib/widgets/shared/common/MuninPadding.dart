import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Common.dart';

/// The default padding for a munin widget.
/// This widget is nothing but an official [Padding] widget with with some munin
/// pre-defined offsets.
class MuninPadding extends StatelessWidget {
  static const defaultPadding = const EdgeInsets.symmetric(
      horizontal: defaultPortraitHorizontalOffset, vertical: baseOffset4x);

  static const vertical1xOffsetPadding = const EdgeInsets.symmetric(
      horizontal: defaultPortraitHorizontalOffset, vertical: baseOffset);

  static const vertical3xOffsetPadding = const EdgeInsets.symmetric(
      horizontal: defaultPortraitHorizontalOffset, vertical: baseOffset3x);

  /// The widget below padding widget in the tree.
  final Widget child;

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry padding;

  const MuninPadding({
    Key key,
    @required this.child,
  })  : assert(child != null),
        this.padding = defaultPadding,
        super(key: key);

  const MuninPadding.vertical1xOffset({
    Key key,
    @required this.child,
  })
      : assert(child != null),
        this.padding = vertical1xOffsetPadding,
        super(key: key);

  const MuninPadding.vertical3xOffset({
    Key key,
    @required this.child,
  })
      : assert(child != null),
        this.padding = vertical3xOffsetPadding,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: child,
    );
  }
}
