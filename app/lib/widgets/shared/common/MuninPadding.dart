import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Common.dart';

/// The default padding for a munin widget.
/// This widget is nothing but an official [Padding] widget with with some munin
/// pre-defined offsets.
class MuninPadding extends StatelessWidget {
  /// The widget below padding widget in the tree.
  final Widget child;

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry padding;

  const MuninPadding({
    Key key,
    @required this.child,
    this.padding: const EdgeInsets.symmetric(
        horizontal: defaultPortraitHorizontalOffset, vertical: baseOffset4x),
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: child,
    );
  }
}
