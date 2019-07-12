import 'package:flutter/material.dart';

class RoundedInkWell extends StatelessWidget {
  final Widget child;

  final GestureTapCallback onTap;

  /// Text that describes the action that will occur when the button is pressed.
  ///
  /// This text is displayed when the user long-presses on the button and is
  /// used for accessibility.
  final String tooltip;

  const RoundedInkWell({
    Key key,
    @required this.child,
    this.onTap,
    this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final roundedInkWell = InkWell(
      child: child,
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
      onTap: onTap,
    );

    if (tooltip != null) {
      return Tooltip(
        child: roundedInkWell,
        message: tooltip,
      );
    }

    return roundedInkWell;
  }
}
