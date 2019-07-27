import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Common.dart';

class GreyRoundedBorderContainer extends StatelessWidget {
  final Widget child;

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry childPadding;

  const GreyRoundedBorderContainer({
    Key key,
    @required this.child,
    this.childPadding = const EdgeInsets.all(baseOffset),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).textTheme.caption.color),
          borderRadius: defaultContainerCircularRadius),
      child: Padding(
        child: child,
        padding: childPadding,
      ),
    );
  }
}
