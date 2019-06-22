import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Common.dart';

class RoundedConcreteBackground extends StatelessWidget {
  final Widget child;

  final Color backgroundColor;

  final BorderRadiusGeometry borderRadius;

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry innerChildPadding;

  /// Padding that's on the outside this widget.
  final EdgeInsetsGeometry outerPadding;

  const RoundedConcreteBackground({
    Key key,
    @required this.child,
    this.backgroundColor,
    this.borderRadius,
    this.innerChildPadding = const EdgeInsets.all(mediumOffset),
    this.outerPadding = const EdgeInsets.symmetric(vertical: smallOffset),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// TODO: find a better way to calculate background color.
    final decorationColor = backgroundColor ??
        Theme.of(context)
            .splashColor
            .withOpacity(Theme.of(context).splashColor.opacity / 3);

    return Padding(
      padding: outerPadding,
      child: Container(
        decoration: BoxDecoration(
          color: decorationColor,
          shape: BoxShape.rectangle,
          borderRadius: defaultContainerCircularRadius,
        ),
        child: Padding(
          padding: innerChildPadding,
          child: child,
        ),
      ),
    );
  }
}
